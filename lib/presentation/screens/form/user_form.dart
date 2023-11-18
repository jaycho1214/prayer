import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';
import 'package:prayer/bloc/auth/authentication_event.dart';
import 'package:prayer/bloc/auth/authentication_state.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/sheet/image_form.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/presentation/widgets/form/upload_progress_bar.dart';
import 'package:prayer/presentation/widgets/form/username_input_form.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/user_repository.dart';

class UserFormScreen extends HookWidget {
  const UserFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final oldUser = useMemoized(
        () => context
            .read<AuthenticationBloc>()
            .state
            .mapOrNull(signedUp: (value) => value.user),
        [context]);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    final progress = useState(0.0);

    final onSubmit = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        final values = formKey.currentState!.value;
        context
            .read<UserRepository>()
            .updateUser(
              username: values['username'],
              name: values['name'],
              bio: values['bio'],
              profile: values['profile'],
              banner: values['banner'],
              onSendProgress: (newProgress) => progress.value = newProgress,
            )
            .then((value) {
          context
              .read<AuthenticationBloc>()
              .add(const AuthenticationEvent.refresh());
          context.pop();
        }).catchError((e) {
          talker.error('Unable to update user: $e');
          GlobalSnackBar.show(context,
              message: "Unable to update. Please try again later");
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
        if (oldUser != null) {
          formKey.currentState?.patchValue({
            "username": oldUser.username,
            "name": oldUser.name,
            "bio": oldUser.bio,
            "profile": oldUser.profile,
            "banner": oldUser.banner,
          });
        }
      });
      return () {};
    }, [formKey, oldUser]);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          leading: NavigateBackButton(),
          backgroundColor: MyTheme.surface,
          title: Text("Profile"),
          trailingActions: [
            Center(
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) => PrimaryTextButton(
                  text: 'Done',
                  onTap: onSubmit,
                  loading: state is AuthenticationStateSignUpLoading,
                ),
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
                        BannerImageForm(initialValue: oldUser?.banner),
                        Positioned(
                          left: 30,
                          bottom: 20,
                          child:
                              ProfileImageForm(initialValue: oldUser?.profile),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          UsernameInputForm(
                            initialValue: oldUser?.username,
                          ),
                          const SizedBox(height: 5),
                          TextInputField(
                            name: 'name',
                            labelText: "Name",
                            maxLength: 30,
                            maxLines: 1,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const TextInputField(
                            name: 'bio',
                            labelText: "Bio",
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
