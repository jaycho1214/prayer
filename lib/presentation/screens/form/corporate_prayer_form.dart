import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_menu_form.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/presentation/widgets/form/upload_progress_bar.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/group_repository.dart';
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
    final initialValue = GoRouterState.of(context).extra as Group?;

    final onCreate = useCallback(() {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        talker.debug("Creating a corporate prayer...");
        final form = formKey.currentState!.value;
        context
            .read<PrayerRepository>()
            .createCorporatePrayer(
              groupId: groupId,
              title: form['title'],
              description: form['description'],
              prayers: form.entries
                  .where((element) =>
                      element.key.startsWith('prayers.') &&
                      element.value != null)
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
          talker.good("Successfully created a corporate prayer");
        }).catchError((e) {
          if (e is DioException) {
            talker.error("Failed to create a corporate prayer: ${e.response}");
          } else {
            talker.error("Failed to create a corporate prayer: ${e}");
          }
          GlobalSnackBar.show(context,
              message: "Failed to create a corporate prayer");
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, []);

    final onEdit = useCallback(() {
      if (initialValue == null) {
        GlobalSnackBar.show(context, message: "Failed to edit a group");
        return;
      }
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        talker.debug("Editing a group...");
        final form = formKey.currentState!.value;
        context
            .read<GroupRepository>()
            .updateGroup(
              groupId: initialValue.id,
              name: form['name'],
              description: form['description'],
              banner:
                  (form['banner'] as String?)?.startsWith('https://') == true
                      ? null
                      : form['banner'],
            )
            .then((value) {
          context.pop(true);
          talker.good("Successfully edited a group");
        }).catchError((e) {
          if (e is DioException) {
            talker.error("Failed to edit a group: ${e.response}");
          }
          GlobalSnackBar.show(context, message: "Failed to edit a group");
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, []);

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
                onTap: initialValue == null ? onCreate : onEdit,
                loading: loading.value,
              ),
            ),
          ],
        ),
        body: FormBuilder(
          key: formKey,
          initialValue: initialValue == null ? {} : initialValue.toJson(),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextInputField(
                                  name: "startedAt",
                                  labelText: "Started From",
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
                                  labelText: "Ended From",
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
                          "After the duration of prayers has elapsed, they will be marked as concluded",
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
                        if (initialValue != null) ...[
                          const Divider(color: MyTheme.disabled),
                          loading.value
                              ? PlatformCircularProgressIndicator()
                              : PrimaryTextButton(
                                  text: "Delete",
                                  onTap: () async {
                                    loading.value = true;
                                    if (await ConfirmMenuForm.show(
                                          context,
                                          title: "Delete a Group",
                                          subtitle:
                                              "You cannot undo this action",
                                          description: [
                                            "\u{26A0} All group members will be removed automatically.",
                                            "\u{26A0} Corporate prayers and their associated prayers will be deleted.",
                                            "\u{26A0} Any prayers posted in this group will be removed.",
                                          ],
                                          icon: FontAwesomeIcons.lightTrash,
                                        ) ==
                                        true) {
                                      context
                                          .read<GroupRepository>()
                                          .removeGroup(initialValue.id)
                                          .then((value) {
                                        Navigator.of(context)
                                            .popUntil(ModalRoute.withName('/'));
                                      }).catchError((_) {
                                        GlobalSnackBar.show(context,
                                            message:
                                                "Unable to delete a group");
                                      }).whenComplete(() {
                                        loading.value = false;
                                      });
                                    }
                                  },
                                  backgroundColor: Colors.red,
                                ),
                        ],
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
