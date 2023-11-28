import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class ReminderDatePickerForm extends HookWidget {
  const ReminderDatePickerForm({super.key});

  Widget buildButton({
    required Widget child,
    Key? key,
    void Function()? onTap,
    Color color = MyTheme.primary,
  }) {
    return ShrinkingButton(
      key: key,
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyTheme.disabled),
          color: color,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final animController = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0.0,
    );
    final anim =
        CurvedAnimation(parent: animController, curve: Curves.easeInQuad);

    final optionValue = useState(false);
    final optionAnimController = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0.0,
    );
    final optionAnim =
        CurvedAnimation(parent: optionAnimController, curve: Curves.easeInQuad);
    final days = useState(<int>[]);
    final time = useState<TimeOfDay?>(null);

    useEffect(() {
      if (optionValue.value) {
        optionAnimController.forward();
        if (days.value.length != 0) {
          animController.forward();
        }
      } else {
        optionAnimController.animateBack(0.0);
      }
      return () => null;
    }, [optionValue.value]);

    return FormBuilderField(
      name: 'reminderTime',
      builder: (FormFieldState<DateTime?> reminderTimeField) {
        if (reminderTimeField.value != null) {
          optionValue.value = true;
          animController.forward();
          optionAnimController.forward();
          time.value = TimeOfDay(
            hour: reminderTimeField.value!.hour,
            minute: reminderTimeField.value!.minute,
          );
        }
        return FormBuilderField(
          name: 'reminder',
          builder: (FormFieldState<String?> reminderField) {
            if (reminderField.value != null) {
              days.value = List<int>.from(jsonDecode(reminderField.value!));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Reminder",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    PlatformSwitch(
                        value: optionValue.value,
                        onChanged: (value) {
                          if (!value) {
                            animController.animateBack(0.0);
                            reminderField.didChange(null);
                          } else {
                            reminderField.didChange(jsonEncode(days.value));
                          }
                          optionValue.value = value;
                        }),
                  ],
                ),
                SizeTransition(
                  sizeFactor: optionAnim,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(7, (index) => index)
                        .map(
                          (day) => buildButton(
                              child: Text(
                                ['S', 'M', 'T', 'W', 'Th', 'F', 'S'][day],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              color: days.value.contains(day)
                                  ? MyTheme.primary
                                  : Colors.transparent,
                              onTap: () {
                                if (days.value.contains(day)) {
                                  days.value = [...days.value..remove(day)];
                                } else {
                                  days.value = [...days.value, day];
                                }
                                if (days.value.length == 0) {
                                  animController.animateBack(0);
                                  reminderField.didChange(null);
                                } else {
                                  reminderField
                                      .didChange(jsonEncode(days.value));
                                  if (time.value == null) {
                                    reminderTimeField.didChange(
                                        DateTime.now().toLocal().copyWith(
                                              hour: 9,
                                              minute: 0,
                                              second: 0,
                                              millisecond: 0,
                                              microsecond: 0,
                                            ));
                                    time.value = TimeOfDay(hour: 9, minute: 0);
                                  }
                                  animController.forward();
                                }
                              }),
                        )
                        .toList(),
                  ),
                ),
                SizeTransition(
                  sizeFactor: anim,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Builder(
                          builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildButton(
                                  onTap: () {
                                    if (time.value != null) {
                                      final oldHour = time.value!.hour;
                                      final oldMinutes = time.value!.minute;
                                      time.value = TimeOfDay(
                                        hour: oldMinutes == 0
                                            ? oldHour - 1 < 0
                                                ? 23
                                                : oldHour - 1
                                            : oldHour,
                                        minute: oldMinutes == 0
                                            ? 50
                                            : oldMinutes - 10,
                                      );
                                      reminderTimeField.didChange(DateTime.now()
                                          .toLocal()
                                          .copyWith(
                                              hour: time.value!.hour,
                                              minute: time.value!.minute));
                                    }
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.chevronLeft,
                                    size: 15,
                                    color: MyTheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  time.value == null
                                      ? ''
                                      : time.value!.format(context),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                buildButton(
                                  onTap: () {
                                    if (time.value != null) {
                                      final oldHour = time.value!.hour;
                                      final oldMinutes = time.value!.minute;
                                      time.value = TimeOfDay(
                                        hour: oldMinutes == 50
                                            ? oldHour + 1 > 23
                                                ? 0
                                                : oldHour + 1
                                            : oldHour,
                                        minute: oldMinutes == 50
                                            ? 0
                                            : oldMinutes + 10,
                                      );
                                      reminderTimeField.didChange(DateTime.now()
                                          .toLocal()
                                          .copyWith(
                                              hour: time.value!.hour,
                                              minute: time.value!.minute));
                                    }
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.chevronRight,
                                    size: 15,
                                    color: MyTheme.onPrimary,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextInputField(
                          name: 'reminderText',
                          maxLength: 100,
                          hintText: 'Let us pray...',
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Your timezone will be used to notify other members",
                          style: TextStyle(
                            color: MyTheme.placeholderText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
