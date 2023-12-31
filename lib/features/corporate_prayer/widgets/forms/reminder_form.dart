import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/forms/day_picker.dart';
import 'package:prayer/features/common/widgets/forms/time_picker.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/utils/formatter.dart';

class ReminderDatePickerForm extends HookWidget {
  const ReminderDatePickerForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormBuilderState> formKey;

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
    final dayAnimController = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0.0,
    );
    final dayAnim =
        CurvedAnimation(parent: dayAnimController, curve: Curves.easeInQuad);
    final days = useState(<int>[]);
    final time = useState<TimeOfDay?>(null);

    useEffect(() {
      final hasActivated =
          formKey.currentState?.initialValue['reminderActivated'] as bool?;
      final timeField =
          formKey.currentState?.initialValue['reminderTime'] as DateTime?;
      final daysField =
          formKey.currentState?.initialValue['reminder'] as String?;
      if (hasActivated == true) {
        dayAnimController.forward();
        time.value = TimeOfDay(
          hour: timeField!.hour,
          minute: timeField.minute,
        );
      }
      if (daysField != null) {
        days.value = List<int>.from(jsonDecode(daysField));
      }

      return () => null;
    }, []);

    return FormBuilderField(
      name: 'reminderTime',
      builder: (FormFieldState<DateTime?> reminderTimeField) {
        return FormBuilderField(
          name: 'reminder',
          validator: (String? value) {
            if (formKey.currentState?.instantValue['reminderActivated'] ==
                    true &&
                (value == null ||
                    List<int>.from(jsonDecode(value)).length == 0)) {
              return 'Please select a day to send reminders';
            }
            return null;
          },
          builder: (FormFieldState<String?> reminderField) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).reminder,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    FormBuilderField<bool>(
                        name: 'reminderActivated',
                        builder: (reminderActivatedField) {
                          return PlatformSwitch(
                              value: reminderActivatedField.value ?? false,
                              onChanged: (value) {
                                reminderActivatedField.didChange(value);
                                if (value) {
                                  dayAnimController.forward();
                                  if (time.value == null) {
                                    reminderTimeField.didChange(
                                        DateTime.now().toLocal().copyWith(
                                              hour: 9,
                                              minute: 0,
                                            ));
                                    time.value = TimeOfDay(hour: 9, minute: 0);
                                  }
                                } else {
                                  dayAnimController.animateBack(0.0);
                                }
                              });
                        }),
                  ],
                ),
                SizeTransition(
                  sizeFactor: dayAnim,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ShrinkingButton(
                        onTap: () async {
                          final resp = await DayPicker.show(context,
                              initialValue: [...days.value]);
                          if (resp == null) {
                            return;
                          }
                          days.value = resp;
                          if (days.value.length > 0) {
                            reminderField.didChange(jsonEncode(days.value));
                            if (time.value == null) {
                              reminderTimeField
                                  .didChange(DateTime.now().toLocal().copyWith(
                                        hour: 9,
                                        minute: 0,
                                      ));
                              time.value = TimeOfDay(hour: 9, minute: 0);
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Day",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (days.value.length > 0)
                                Expanded(
                                  child: Text(
                                    Formatter.daysToString(days.value),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: MyTheme.placeholderText,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              if (days.value.length == 0)
                                FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: MyTheme.onPrimary,
                                  size: 15,
                                ),
                            ],
                          ),
                        ),
                      ),
                      ShrinkingButton(
                        onTap: () async {
                          final resp = await TimePicker.show(
                            context,
                            initialValue: time.value,
                            minuteInterval: 10,
                          );
                          if (resp == null) {
                            return;
                          }
                          time.value = resp;
                          reminderTimeField.didChange(DateTime.now()
                              .toLocal()
                              .copyWith(hour: resp.hour, minute: resp.minute));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Time",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (time.value != null)
                                Expanded(
                                  child: Text(
                                    time.value!.format(context),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: MyTheme.placeholderText,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              if (time.value == null)
                                FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: MyTheme.onPrimary,
                                  size: 15,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          TextInputField(
                            name: 'reminderText',
                            maxLength: 100,
                            hintText: S.of(context).placeholderReminder,
                            validator: (value) {
                              if (formKey.currentState
                                      ?.instantValue['reminderActivated'] ==
                                  true) {
                                if ((value ?? '').trim().length == 0) {
                                  return S
                                      .of(context)
                                      .errorProvideReminderMessage;
                                }
                                if (days.value.length == 0) {
                                  return S.of(context).errorNeedDayReminder;
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            S.of(context).titleTimezoneWillBeUsed,
                            style: TextStyle(
                              color: MyTheme.placeholderText,
                            ),
                          ),
                        ],
                      ),
                    ],
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
