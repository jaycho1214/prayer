import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_menu_form.dart';
import 'package:prayer/presentation/widgets/form/sheet/image_form.dart';
import 'package:prayer/presentation/widgets/form/membership_type_form.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/presentation/widgets/form/upload_progress_bar.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupFormScreen extends HookWidget {
  const GroupFormScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final initialValue = GoRouterState.of(context).extra as Group?;

    final onCreate = useCallback(() {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        talker.debug("Creating a group...");
        final form = formKey.currentState!.value;
        if (form['banner'] == null) {
          loading.value = false;
          return GlobalSnackBar.show(context,
              message: "Please upload a banner");
        }
        GetIt.I<GroupRepository>()
            .createGroup(
          name: form['name'],
          description: form['description'],
          membershipType: form['membershipType'],
          banner: form['banner'],
        )
            .then((value) {
          context.pop(true);
          talker.good("Successfully created a group");
        }).catchError((e) {
          if (e is DioException) {
            talker.error("Failed to create a group: ${e.response}");
          }
          GlobalSnackBar.show(context, message: "Failed to create a group");
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
        if (form['banner'] == null ||
            (form['banner'] as String?)?.startsWith('https') == false) {
          loading.value = false;
          return GlobalSnackBar.show(context,
              message: "Please upload a banner");
        }
        GetIt.I<GroupRepository>()
            .updateGroup(
          groupId: initialValue.id,
          name: form['name'],
          description: form['description'],
          banner: form['banner'],
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
          title: Text("Create a Group"),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: initialValue == null ? "Create" : "Edit",
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
                  const BannerImageForm(aspectRatio: 0.5),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        TextInputField(
                          name: 'name',
                          labelText: 'Group Name',
                          maxLines: 1,
                          maxLength: 30,
                          validator: (value) {
                            if (value == null || value.trim() == '') {
                              return 'Name must include at least one non-whitespace character';
                            }
                            if (value.contains('@') || value.contains('#')) {
                              return "Name must not include the '#' or the '@' symbol";
                            }
                            if (value.startsWith(' ')) {
                              return "Name must not start with whitespace";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Names must be less than 30 characters and do not include hashtag and or the '@' symbol.",
                          style: const TextStyle(
                            color: MyTheme.outline,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: MyTheme.disabled),
                        const SizedBox(height: 10),
                        TextInputField(
                          name: 'description',
                          labelText: 'Group Description',
                          maxLines: 10,
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
                        Text(
                          "Tell us a detail about your Group, such as its purpose or mission.",
                          style: const TextStyle(
                            color: MyTheme.outline,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                                      GetIt.I<GroupRepository>()
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
                                    } else {
                                      loading.value = false;
                                    }
                                  },
                                  backgroundColor: Colors.red,
                                ),
                        ],
                        if (initialValue == null) ...[
                          const Divider(color: MyTheme.disabled),
                          const SizedBox(height: 10),
                          Text(
                            "Membership Type",
                            style: const TextStyle(
                              color: MyTheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "Tell us who can join this group. You cannot change this later.",
                            style: const TextStyle(
                                color: MyTheme.disabled, fontSize: 12),
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
