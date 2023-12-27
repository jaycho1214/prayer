import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/user/widgets/forms/profile_bible_verse_form.dart';
import 'package:prayer/features/user/widgets/forms/user_image_form.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/common/widgets/forms/upload_progress_bar.dart';
import 'package:prayer/features/user/widgets/forms/username_input_form.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';
import 'package:prayer/features/user/providers/user_provider.dart';
import 'package:prayer/repo/user_repository.dart';

class UserFormScreen extends HookConsumerWidget {
  const UserFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oldUser =
        (ref.watch(authNotifierProvider).requireValue as AuthStateSignedUp)
            .user;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final progress = useState(0.0);

    final onSubmit = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        final values = formKey.currentState!.value;
        GetIt.I<UserRepository>()
            .updateUser(
          username: values['username'],
          name: values['name'],
          bio: values['bio'],
          profile: values['profile'],
          banner: values['banner'],
          verseId: values['verseId'],
          onSendProgress: (newProgress) => progress.value = newProgress,
        )
            .then((value) {
          if (value == 'success') {
            talker.good('[UserForm] User Updated');
            ref.invalidate(userNotifierProvider(
                uid: FirebaseAuth.instance.currentUser!.uid));
            context.pop('updated');
          }
        }).catchError((e, st) {
          talker.handle(e, st, '[UserForm] Failed to update: $values');
          GlobalSnackBar.show(context,
              message: S.of(context).errorUnableToUpdate);
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, [
      context,
      formKey,
    ]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        formKey.currentState?.patchValue({
          "username": oldUser.username,
          "name": oldUser.name,
          "bio": oldUser.bio,
          "profile": oldUser.profile,
          "banner": oldUser.banner,
          "verseId": oldUser.verseId,
        });
      });
      return () {};
    }, [formKey, oldUser]);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          leading: NavigateBackButton(),
          backgroundColor: MyTheme.surface,
          title: Text(S.of(context).profile),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: S.of(context).done,
                onTap: onSubmit,
                loading: loading.value,
              ),
            ),
          ],
        ),
        body: FormBuilder(
          key: formKey,
          child: Container(
            color: MyTheme.surface,
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width + 50,
                        ),
                        BannerImageForm(initialValue: oldUser.banner),
                        Positioned(
                          left: 30,
                          bottom: 20,
                          child:
                              ProfileImageForm(initialValue: oldUser.profile),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileBibleVerseForm(),
                          const SizedBox(height: 20),
                          UsernameInputForm(
                            initialValue: oldUser.username,
                          ),
                          const SizedBox(height: 5),
                          TextInputField(
                            name: 'name',
                            labelText: S.of(context).name,
                            maxLength: 30,
                            maxLines: 1,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return S.of(context).errorEnterName;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextInputField(
                            name: 'bio',
                            labelText: S.of(context).bio,
                            maxLength: 200,
                            maxLines: 10,
                            minLines: 10,
                            keyboardType: TextInputType.multiline,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: UploadProgressBar(progress: progress.value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
