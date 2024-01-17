import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/features/corporate_prayer/widgets/forms/reminder_form.dart';
import 'package:prayer/features/group/models/group_rule/group_rule.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/common/sheets/confirm_menu_form.dart';
import 'package:prayer/features/user/widgets/forms/user_image_form.dart';
import 'package:prayer/features/group/widgets/forms/membership_type_form.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/common/widgets/forms/upload_progress_bar.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupFormScreen extends HookConsumerWidget {
  const GroupFormScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final initialValue = GoRouterState.of(context).extra as Group?;

    final handleAction = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        try {
          loading.value = true;
          final form = formKey.currentState!.value;
          if (initialValue == null) {
            talker.debug("[Group] Creating: $form");
          } else {
            talker.debug("[Group] Editing: $form");
          }
          if (form['banner'] == null) {
            loading.value = false;
            return GlobalSnackBar.show(context,
                message: t.error.needGroupBanner);
          }
          final rules = List.generate(10, (index) {
            final title = form['rules.$index.title'];
            final description = form['rules.$index.description'];
            if ((title ?? '').trim() == '' ||
                (description ?? '').trim() == '') {
              return null;
            }
            return GroupRule(title: title, description: description);
          }).whereType<GroupRule>().toList();
          if (initialValue == null) {
            await GetIt.I<GroupRepository>().createGroup(
              name: form['name'],
              description: form['description'],
              membershipType: form['membershipType'],
              banner: form['banner'],
              rules: rules,
              reminderDays: form['reminderActivated'] == true
                  ? List<int>.from(jsonDecode(form['reminder']))
                  : null,
              reminderText: form['reminderActivated'] == true
                  ? form['reminderText']
                  : null,
              reminderTime: form['reminderActivated'] == true
                  ? form['reminderTime']
                  : null,
              welcomeTitle: form['welcomeTitle'],
              welcomeMessage: form['welcomeMessage'],
            );
            mixpanel.track('Group Created');
            talker.good("[Group] Created");
          } else {
            await GetIt.I<GroupRepository>().updateGroup(
              groupId: initialValue.id,
              name: form['name'],
              description: form['description'],
              banner: form['banner'],
              rules: rules,
              reminderDays: form['reminderActivated'] == true
                  ? List<int>.from(jsonDecode(form['reminder']))
                  : null,
              reminderText: form['reminderActivated'] == true
                  ? form['reminderText']
                  : null,
              reminderTime: form['reminderActivated'] == true
                  ? form['reminderTime']
                  : null,
              welcomeTitle: form['welcomeTitle'],
              welcomeMessage: form['welcomeMessage'],
            );
            mixpanel.track('Group Edited');
            talker.good("[Group] Edited");
          }
          context.pop(true);
        } catch (e, st) {
          talker.handle(e, st, "[Group] Failed to create");
          return GlobalSnackBar.show(context,
              message: initialValue == null
                  ? t.error.createGroup
                  : t.error.editGroup);
        } finally {
          loading.value = false;
        }
      }
    }, []);

    final handleInitialValue = useMemoized(() {
      if (initialValue == null) {
        return {'membershipType': 'open'};
      }
      final data = initialValue.toJson();
      initialValue.rules?.asMap().entries.forEach((element) {
        data['rules.${element.key}.title'] = element.value.title;
        data['rules.${element.key}.description'] = element.value.description;
      });
      if (initialValue.reminder != null) {
        data['reminderActivated'] = true;
        data['reminderTime'] = initialValue.reminder!.time;
        data['reminder'] = jsonEncode(initialValue.reminder!.days);
        data['reminderText'] = initialValue.reminder!.value;
      }
      data['welcomeTitle'] = initialValue.welcomeTitle;
      data['welcomeMessage'] = initialValue.welcomeMessage;
      return data;
    }, []);

    return DefaultTabController(
      length: 2,
      child: KeyboardDismissOnTap(
        child: PlatformScaffold(
          iosContentPadding: true,
          appBar: PlatformAppBar(
            automaticallyImplyLeading: true,
            leading: NavigateBackButton(result: false),
            title: Text(t.general.createGroup),
            trailingActions: [
              Center(
                child: PrimaryTextButton(
                  text:
                      initialValue == null ? t.general.create : t.general.edit,
                  onTap: handleAction,
                  loading: loading.value,
                ),
              ),
            ],
          ),
          body: FormBuilder(
            key: formKey,
            initialValue: handleInitialValue,
            child: Stack(
              children: [
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: UploadProgressBar(),
                ),
                NestedScrollView(
                  headerSliverBuilder: (context, _) => [
                    SliverToBoxAdapter(
                      child: BannerImageForm(
                        aspectRatio: 0.5,
                        initialValue: initialValue?.banner,
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: TabBarDelegate(
                        tabs: [t.general.group, 'Rules'],
                      ),
                    ),
                  ],
                  body: TabBarView(
                    children: [
                      GroupMainForm(
                        initialValue: initialValue,
                        formKey: formKey,
                      ),
                      GroupRulesForm(formKey: formKey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupMainForm extends HookWidget {
  const GroupMainForm({
    super.key,
    this.initialValue,
    required this.formKey,
  });

  final Group? initialValue;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return ListView(
      padding: const EdgeInsets.only(top: 10),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputField(
                name: 'name',
                labelText: t.group.form.main.name.title,
                maxLines: 1,
                maxLength: 30,
                validator: (value) {
                  if (value == null || value.trim() == '') {
                    return t.error.corporatePrayerMustNotEmpty;
                  } else if (value.contains('@') ||
                      value.contains('#') ||
                      value.startsWith(' ')) {
                    return t.error.corporatePrayerHasSpecialCharacters;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Text(
                t.group.form.main.name.subtitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              TextInputField(
                name: 'description',
                labelText: t.group.form.main.description.title,
                maxLines: 10,
                maxLength: 300,
                counterText: '',
                validator: (value) {
                  if ((value ?? "").trim() == '') {
                    return t.error.needGroupDescription;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Text(
                t.group.form.main.description.subtitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              ReminderDatePickerForm(
                formKey: formKey,
                title: t.group.form.main.prayerTime.title,
              ),
              const SizedBox(height: 10),
              Text(
                t.group.form.main.prayerTime.description,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 10),
              if (initialValue != null) ...[
                const Divider(),
                const SizedBox(height: 20),
                loading.value
                    ? PlatformCircularProgressIndicator()
                    : PrimaryTextButton(
                        text: t.general.delete,
                        onTap: () async {
                          loading.value = true;
                          if (await ConfirmMenuForm.show(
                                context,
                                title: t.general.deleteGroup,
                                subtitle: t.alert.actionIrreversible,
                                description: t.group.alert.deleteGroup,
                                icon: FontAwesomeIcons.lightTrash,
                              ) ==
                              true) {
                            GetIt.I<GroupRepository>()
                                .removeGroup(initialValue!.id)
                                .then((value) {
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName('/'));
                            }).catchError((_) {
                              GlobalSnackBar.show(context,
                                  message: t.error.deleteGroup);
                            }).whenComplete(() {
                              loading.value = false;
                            });
                          } else {
                            loading.value = false;
                          }
                        },
                        backgroundColor: Colors.red,
                      ),
              ],
              if (initialValue == null) ...[
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  t.group.form.main.membershipType.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  t.group.form.main.membershipType.subtitle,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 10),
                const MembershipTypeForm(),
              ],
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }
}

class GroupRulesForm extends StatefulWidget {
  const GroupRulesForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormBuilderState> formKey;

  @override
  State<GroupRulesForm> createState() => _GroupRulesFormState();
}

class _GroupRulesFormState extends State<GroupRulesForm> {
  final focusNodes = List.generate(10, (index) => FocusNode());
  int rules = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      rules = min(
          (widget.formKey.currentState?.initialValue.keys
                      .where((element) => element.startsWith('rules'))
                      .length ??
                  0) ~/
              2,
          1);
    });
  }

  @override
  void dispose() {
    focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  Widget _buildIcon({
    required IconData icon,
    bool disabled = false,
    void Function()? onTap,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: disabled
              ? Theme.of(context).disabledColor
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FaIcon(
          icon,
          size: 15,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      children: [
        TextInputField(
          name: 'welcomeTitle',
          labelText: t.group.form.main.welcome.title,
          maxLines: 1,
          maxLength: 100,
        ),
        const SizedBox(height: 10),
        TextInputField(
          name: 'welcomeMessage',
          labelText: t.group.form.main.welcome.message,
          maxLines: 5,
          maxLength: 500,
        ),
        Text(
          t.group.form.main.welcome.description,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        ...List.generate(
          10,
          (index) => Visibility(
            visible: index < rules || index == 0,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: [
                  TextInputField(
                    name: 'rules.${index}.title',
                    focusNode: focusNodes[index],
                    labelText: '${t.general.rule} ${index + 1}',
                    scrollPadding: const EdgeInsets.only(bottom: 50),
                    hintText: t.general.title,
                    maxLines: 1,
                    maxLength: 100,
                    validator: (p0) {
                      if (index < rules && (p0 ?? '').trim() == '') {
                        return t.error.fieldRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextInputField(
                    name: 'rules.${index}.description',
                    hintText: t.general.description,
                    scrollPadding: const EdgeInsets.only(bottom: 180),
                    maxLines: 3,
                    maxLength: 300,
                    validator: (p0) {
                      if (index < rules && (p0 ?? '').trim() == '') {
                        return t.error.fieldRequired;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIcon(
                icon: FontAwesomeIcons.minus,
                disabled: rules < 2,
                onTap: () {
                  if (rules < 2) {
                    return;
                  }
                  widget.formKey.currentState?.fields['prayers.${rules - 1}']
                      ?.didChange(null);
                  setState(() {
                    rules = rules - 1;
                  });
                  focusNodes[rules - 1].requestFocus();
                },
              ),
              const SizedBox(width: 10),
              _buildIcon(
                icon: FontAwesomeIcons.plus,
                disabled: rules > 9,
                onTap: () {
                  final value = rules;
                  setState(() {
                    rules = value > 9 ? 10 : value + 1;
                  });
                  focusNodes[value].requestFocus();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
