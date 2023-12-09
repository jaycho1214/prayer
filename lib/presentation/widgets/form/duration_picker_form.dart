import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';

class DurationPickerForm extends StatelessWidget {
  const DurationPickerForm({super.key});

  Future<void> onTapStart(
    BuildContext context, {
    required FormFieldState<Jiffy?> startedAtField,
    required FormFieldState<Jiffy?> endedAtField,
  }) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final date = await showPlatformDatePicker(
      context: context,
      initialDate: DateUtils.dateOnly(DateTime.now()),
      firstDate: DateUtils.dateOnly(DateTime.now()),
      lastDate: DateTime(9999),
      cupertino: (context, platform) => CupertinoDatePickerData(
        mode: CupertinoDatePickerMode.date,
      ),
    );
    startedAtField
        .didChange(date == null ? null : Jiffy.parseFromDateTime(date));
    if (date == null) {
      endedAtField.didChange(null);
    }
  }

  Future<void> onTapEnd(
    BuildContext context, {
    required FormFieldState<Jiffy?> startedAtField,
    required FormFieldState<Jiffy?> endedAtField,
  }) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime? startedAt = startedAtField.value?.dateTime;
    startedAt = startedAt == null ? null : startedAt;
    if (startedAt == null) {
      return GlobalSnackBar.show(context,
          message: "Please specify started from first");
    }
    final date = await showPlatformDatePicker(
      context: context,
      initialDate: DateUtils.dateOnly(startedAt),
      firstDate: DateUtils.dateOnly(startedAt),
      lastDate: DateTime(9999),
      cupertino: (context, platform) => CupertinoDatePickerData(
        mode: CupertinoDatePickerMode.date,
      ),
    );
    endedAtField.didChange(date == null ? null : Jiffy.parseFromDateTime(date));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).startedAt,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: MyTheme.outline,
            ),
          ),
          child: FormBuilderField(
              name: 'startedAt',
              builder: (FormFieldState<Jiffy?> startedAtField) {
                return FormBuilderField(
                    name: 'endedAt',
                    builder: (FormFieldState<Jiffy?> endedAtField) {
                      return Row(
                        children: [
                          Expanded(
                            child: ShrinkingButton(
                              onTap: () => onTapStart(
                                context,
                                startedAtField: startedAtField,
                                endedAtField: endedAtField,
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  startedAtField.value == null
                                      ? S.of(context).startedAt
                                      : startedAtField.value!.yMMMMd,
                                  style: TextStyle(
                                    color: startedAtField.value == null
                                        ? MyTheme.placeholderText
                                        : MyTheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.lightArrowRight,
                            size: 15,
                            color: MyTheme.onPrimary,
                          ),
                          Expanded(
                            child: ShrinkingButton(
                              onTap: () => onTapEnd(
                                context,
                                startedAtField: startedAtField,
                                endedAtField: endedAtField,
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  endedAtField.value == null
                                      ? S.of(context).endedAt
                                      : endedAtField.value!.yMMMMd,
                                  style: TextStyle(
                                    color: endedAtField.value == null
                                        ? MyTheme.placeholderText
                                        : MyTheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }),
        ),
      ],
    );
  }
}
