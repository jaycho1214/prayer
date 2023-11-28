import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/corporate_prayer_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/reminder_form.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/presentation/widgets/form/upload_progress_bar.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/prayer_repository.dart';

class CorporatePrayerForm extends HookWidget {
  const CorporatePrayerForm({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final prayers = useState(1);
    final initialValue = GoRouterState.of(context).extra as CorporatePrayer?;

    final onClick = useCallback(() {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        talker.debug(initialValue == null
            ? "Creating a corporate prayer..."
            : "Updating a corporate prayer");
        final form = formKey.currentState!.value;
        loading.value = false;
        GetIt.I<PrayerRepository>()
            .createOrUpdateCorporatePrayer(
          corporateId: initialValue?.id,
          groupId: groupId,
          title: form['title'],
          description: form['description'],
          reminderDays:
              form['reminderActivated'] == true ? form['reminder'] : null,
          reminderText:
              form['reminderActivated'] == true ? form['reminderText'] : null,
          reminderTime:
              form['reminderActivated'] == true ? form['reminderTime'] : null,
          prayers: form.entries
              .where((element) =>
                  element.key.startsWith('prayers.') && element.value != null)
              .map((e) => e.value as String)
              .toList(),
          startedAt: form['startedAt'] == null
              ? null
              : Jiffy.parse(form['startedAt'], pattern: 'yMMMd').dateTime,
          endedAt: form['endedAt'] == null
              ? null
              : Jiffy.parse(form['endedAt'], pattern: 'yMMMd').dateTime,
        )
            .then((value) {
          context.pop(true);
          talker.good(
              "Successfully ${initialValue == null ? 'created' : 'updated'} a corporate prayer");
        }).catchError((e) {
          if (e is DioException) {
            talker.error(
                "Failed to ${initialValue == null ? 'create' : 'update'} a corporate prayer: ${e.error}");
          } else {
            talker.error(
                "Failed to ${initialValue == null ? 'create' : 'update'} a corporate prayer: ${e}");
          }
          GlobalSnackBar.show(context,
              message: "Failed to create a corporate prayer");
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, []);

    final handleInitialValue = useCallback((CorporatePrayer prayer) {
      final data = prayer.toJson();
      prayer.prayers?.asMap().forEach((index, element) {
        data['prayers.$index'] = element;
      });
      prayers.value = prayer.prayers?.length ?? 1;
      if (prayer.startedAt != null) {
        data['startedAt'] =
            Jiffy.parseFromDateTime(prayer.startedAt!.toLocal()).yMMMd;
      }
      if (prayer.endedAt != null) {
        data['endedAt'] =
            Jiffy.parseFromDateTime(prayer.endedAt!.toLocal()).yMMMd;
      }
      if (prayer.reminder != null) {
        data['reminderActivated'] = true;
        data['reminderTime'] = prayer.reminder!.time;
        data['reminder'] = jsonEncode(prayer.reminder!.days);
        data['reminderText'] = prayer.reminder!.value;
      }
      return data;
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: PlatformScaffold(
        backgroundColor: MyTheme.surface,
        appBar: PlatformAppBar(
          backgroundColor: MyTheme.surface,
          automaticallyImplyLeading: true,
          leading: NavigateBackButton(result: false),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: initialValue == null ? "Post" : "Edit",
                onTap: onClick,
                loading: loading.value,
              ),
            ),
          ],
        ),
        body: FormBuilder(
          key: formKey,
          initialValue:
              initialValue == null ? {} : handleInitialValue(initialValue),
          child: Stack(
            children: [
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: UploadProgressBar(),
              ),
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "After they prayed, the place where they were meeting was shaken. And they were all filled with the Holy Spirit and spoke the word of God boldly.",
                          style: const TextStyle(
                            color: MyTheme.outline,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Center(
                          child: Text(
                            "- Acts 4:31 (NIV)",
                            style: const TextStyle(
                              color: MyTheme.outline,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'title',
                          labelText: 'Title',
                          maxLines: 1,
                          maxLength: 30,
                          validator: (value) {
                            if (value == null || value.trim() == '') {
                              return 'Name must include at least one non-whitespace character';
                            }
                            if (value.contains('@') || value.contains('#')) {
                              return "Name must not include the '#' or the '@' symbol";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'description',
                          labelText: 'Description',
                          maxLines: 5,
                          maxLength: 300,
                          counterText: '',
                          validator: (value) {
                            if ((value ?? "").trim() == '') {
                              return "Please provide a description for the group";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.outline),
                        const SizedBox(height: 10),
                        ReminderDatePickerForm(
                          formKey: formKey,
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.outline),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextInputField(
                                  name: "startedAt",
                                  labelText: "Started At",
                                  keyboardType: TextInputType.none,
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    final date = await showPlatformDatePicker(
                                      context: context,
                                      initialDate:
                                          DateUtils.dateOnly(DateTime.now()),
                                      firstDate:
                                          DateUtils.dateOnly(DateTime.now()),
                                      lastDate: DateTime(9999),
                                      cupertino: (context, platform) =>
                                          CupertinoDatePickerData(
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    );
                                    formKey.currentState?.fields['startedAt']
                                        ?.didChange(date == null
                                            ? null
                                            : Jiffy.parseFromDateTime(date)
                                                .yMMMd);
                                    if (date == null) {
                                      formKey.currentState?.fields['endedAt']
                                          ?.didChange(null);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: TextInputField(
                                  name: "endedAt",
                                  labelText: "Ended At",
                                  keyboardType: TextInputType.none,
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    dynamic startedAt = formKey.currentState
                                        ?.fields['startedAt']?.value as String?;
                                    startedAt = startedAt == null
                                        ? null
                                        : Jiffy.parse(startedAt,
                                                pattern: 'yMMMd')
                                            .dateTime;
                                    if (startedAt == null) {
                                      return GlobalSnackBar.show(context,
                                          message:
                                              "Please specify started from first");
                                    }
                                    final date = await showPlatformDatePicker(
                                      context: context,
                                      initialDate:
                                          DateUtils.dateOnly(startedAt),
                                      firstDate: DateUtils.dateOnly(startedAt),
                                      lastDate: DateTime(9999),
                                      cupertino: (context, platform) =>
                                          CupertinoDatePickerData(
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    );
                                    formKey.currentState?.fields['endedAt']
                                        ?.didChange(date == null
                                            ? null
                                            : Jiffy.parseFromDateTime(date)
                                                .yMMMd);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "After the duration of prayers has elapsed, they will be marked as concluded, and reminders will not be sent.",
                          style: const TextStyle(
                            color: MyTheme.outline,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.outline),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Prayers",
                              style: const TextStyle(
                                color: MyTheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            ShrinkingButton(
                              onTap: () {
                                if (prayers.value < 2) {
                                  return;
                                }
                                prayers.value = prayers.value - 1;
                                formKey.currentState
                                    ?.fields['prayers.${prayers.value}']
                                    ?.didChange(null);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: prayers.value < 2
                                      ? MyTheme.disabled
                                      : MyTheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.minus,
                                  size: 15,
                                  color: MyTheme.onPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ShrinkingButton(
                              onTap: () {
                                prayers.value =
                                    prayers.value > 9 ? 10 : prayers.value + 1;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: prayers.value > 9
                                      ? MyTheme.disabled
                                      : MyTheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 15,
                                  color: MyTheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(
                          prayers.value,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: TextInputField(
                              name: 'prayers.${index}',
                              labelText: 'Prayer ${index + 1}',
                              maxLines: 5,
                              maxLength: 200,
                              counterText: '',
                              validator: (value) {
                                if ((value ?? "").trim() == '') {
                                  return "Please provide a prayer for the group";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
