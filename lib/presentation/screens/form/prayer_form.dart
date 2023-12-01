import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/corporate_prayer_Form.dart';
import 'package:prayer/presentation/widgets/form/prayer_group_form.dart';
import 'package:prayer/presentation/widgets/form/sheet/prayer_visibility_form.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/providers/auth/auth_provider.dart';
import 'package:prayer/providers/auth/auth_state.dart';
import 'package:prayer/repo/prayer_repository.dart';

class PrayerFormScreen extends HookConsumerWidget {
  const PrayerFormScreen({
    super.key,
    this.groupId,
    this.corporateId,
  });

  final String? groupId;
  final String? corporateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final user =
        (ref.watch(authNotifierProvider).requireValue as AuthStateSignedUp)
            .user;
    final anon = useState(false);
    final loading = useState(false);
    final _groupId = useState<String?>(groupId);
    final media = useState<String?>(null);
    final focusNode = useFocusNode();

    final submit = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        final form = formKey.currentState!.value;
        GetIt.I<PrayerRepository>()
            .createPrayer(
          value: form['value'],
          groupId: form['groupId'],
          corporateId: form['corporateId'],
          anon: anon.value,
          media: media.value,
        )
            .then((value) {
          talker.good('Prayer posted: $value');
          Navigator.of(context).pop(true);
        }).catchError((e) {
          talker.error('Failed to post a prayer: $e', e);
          GlobalSnackBar.show(context, message: "Unable to post a prayer");
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, []);

    final pickImage = useCallback(() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image == null) {
        return;
      }
      final cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1.0,
          ratioY: 1.0,
        ),
        aspectRatioPresets: [CropAspectRatioPreset.square],
      );
      if (cropped == null) {
        return;
      }
      media.value = cropped.path;
    }, []);

    return FormBuilder(
      key: formKey,
      initialValue: {'groupId': _groupId.value, 'corporateId': corporateId},
      child: Stack(
        children: [
          PlatformScaffold(
            backgroundColor: MyTheme.surface,
            appBar: PlatformAppBar(
              backgroundColor: MyTheme.surface,
              leading: NavigateBackButton(),
              trailingActions: [
                Center(
                  child: loading.value
                      ? PlatformCircularProgressIndicator()
                      : PrimaryTextButton(
                          onTap: submit,
                          text: anon.value ? 'Pray as Anonymous' : 'Pray',
                        ),
                ),
              ],
            ),
            body: GestureDetector(
              child: ListView(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      UserProfileImage(
                        profile: user.profile,
                        size: 40,
                      ),
                      const SizedBox(width: 10),
                      PrayerGroupForm(
                        onChange: (newGroupId) {
                          _groupId.value = newGroupId;
                          formKey.currentState?.fields['corporateId']
                              ?.didChange(null);
                          focusNode.requestFocus();
                        },
                      ),
                      if (_groupId.value != null) ...[
                        const SizedBox(width: 10),
                        CorporatePrayerForm(
                          groupId: _groupId.value!,
                          onChange: (_) {
                            focusNode.requestFocus();
                          },
                        ),
                      ],
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
                    child: FormBuilderTextField(
                      focusNode: focusNode,
                      name: 'value',
                      minLines: 7,
                      maxLines: 7,
                      autofocus: true,
                      validator: (value) {
                        if ((value ?? '').trim() == '') {
                          return 'Prayer must include at least one non-whitespace character';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Write a prayer...",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (media.value != null) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 50, 0),
                        child: ShrinkingButton(
                          onTap: () {
                            media.value = null;
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(media.value!),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyTheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: FaIcon(
                                    FontAwesomeIcons.xmark,
                                    size: 15,
                                    color: MyTheme.onPrimary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            child: Container(
              color: MyTheme.surface,
              child: Stack(
                children: [
                  Divider(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ShrinkingButton(
                              onTap: pickImage,
                              child: FaIcon(
                                FontAwesomeIcons.image,
                                size: 20,
                                color: MyTheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      ShrinkingButton(
                        onTap: () async {
                          anon.value = await PrayerVisibilityForm.show(context,
                                  anonymous: anon.value) ??
                              anon.value;
                          focusNode.requestFocus();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 15),
                          child: Row(
                            children: [
                              FaIcon(
                                anon.value
                                    ? FontAwesomeIcons.lightUserSlash
                                    : FontAwesomeIcons.lightUser,
                                size: 15,
                                color: MyTheme.onPrimary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                !anon.value
                                    ? "Everyone can see your name"
                                    : "Your prayer is anonymous",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
