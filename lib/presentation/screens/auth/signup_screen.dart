import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/presentation/widgets/form/username_input_form.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/providers/auth/auth_provider.dart';
import 'package:prayer/providers/auth/auth_state.dart';
import 'package:prayer/repo/user_repository.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.value is AuthStateSignedUp) {
        context.go('/');
      }
    });

    final loading = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    final onSubmit = useCallback(() {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        final form = formKey.currentState!.value;
        GetIt.I<UserRepository>()
            .createUser(
          username: form['username'],
          name: form['name'],
          bio: form['bio'],
        )
            .then((value) {
          ref.read(authNotifierProvider.notifier).updateUser(value);
        }).catchError((e) {
          if (e is DuplicatedUsernameException) {
            GlobalSnackBar.show(context,
                message: 'Username ${form['username']} is already taken');
            return;
          }
          GlobalSnackBar.show(context, message: e.toString());
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }, [
      context,
      formKey,
    ]);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          backgroundColor: MyTheme.surface,
          title: Text(
            "Profile",
            style: const TextStyle(color: MyTheme.onPrimary),
          ),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: 'Done',
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
            child: ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Text(
                        "Rejoice always, pray continually, give thanks in all circumstances; for this is God’s will for you in Christ Jesus.",
                        style: TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: MyTheme.outline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "1 Thessalonians 5:16-18 (NIV)",
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                          color: MyTheme.outline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const UsernameInputForm(),
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
          ),
        ),
      ),
    );
  }
}
