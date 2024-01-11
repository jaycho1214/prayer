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
import 'package:prayer/features/group/providers/group_provider.dart';

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

    final onCreate = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        try {
          loading.value = true;
          final form = formKey.currentState!.value;
          talker.debug("[Group] Creating: $form");
          if (form['banner'] == null) {
            loading.value = false;
            return GlobalSnackBar.show(context,
                message: t.error.needGroupBanner);
          }
          await GetIt.I<GroupRepository>().createGroup(
            name: form['name'],
            description: form['description'],
            membershipType: form['membershipType'],
            banner: form['banner'],
          );
          context.pop(true);
          mixpanel.track('Group Created');
          talker.good("[Group] Created");
        } catch (e, st) {
          talker.handle(e, st, "[Group] Failed to create");
          return GlobalSnackBar.show(context, message: t.error.createGroup);
        } finally {
          loading.value = false;
        }
      }
    }, []);

    final onEdit = useCallback(() async {
      try {
        if (initialValue == null) {
          return GlobalSnackBar.show(context, message: t.error.editGroup);
        }
        if (formKey.currentState?.saveAndValidate() == true) {
          loading.value = true;
          final form = formKey.currentState!.value;
          talker.debug("[Group] Editing: $form");
          if (form['banner'] == null) {
            loading.value = false;
            return GlobalSnackBar.show(context,
                message: t.error.needGroupBanner);
          }
          await GetIt.I<GroupRepository>().updateGroup(
            groupId: initialValue.id,
            name: form['name'],
            description: form['description'],
            banner: form['banner'],
          );
          mixpanel.track('Group Edited');
          context.pop(true);
          talker.good("[Group] Edited");
          return ref.invalidate(groupNotifierProvider(initialValue.id));
        }
      } catch (e, st) {
        talker.handle(e, st, "[Group] Failed to edit");
        GlobalSnackBar.show(context, message: t.error.editGroup);
      } finally {
        loading.value = false;
      }
    }, []);

    return KeyboardDismissOnTap(
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          automaticallyImplyLeading: true,
          leading: NavigateBackButton(result: false),
          title: Text(t.general.createGroup),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: initialValue == null ? t.general.create : t.general.edit,
                onTap: initialValue == null ? onCreate : onEdit,
                loading: loading.value,
              ),
            ),
          ],
        ),
        body: FormBuilder(
          key: formKey,
          initialValue: initialValue == null
              ? {
                  'membershipType': 'open',
                }
              : initialValue.toJson(),
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
                  BannerImageForm(
                    aspectRatio: 0.5,
                    initialValue: initialValue?.banner,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
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
                              return t
                                  .error.corporatePrayerHasSpecialCharacters;
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
                        Text(
                          t.group.form.main.description.subtitle,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 10),
                        if (initialValue != null) ...[
                          const Divider(),
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
                                          description:
                                              t.group.alert.deleteGroup,
                                          icon: FontAwesomeIcons.lightTrash,
                                        ) ==
                                        true) {
                                      GetIt.I<GroupRepository>()
                                          .removeGroup(initialValue.id)
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
