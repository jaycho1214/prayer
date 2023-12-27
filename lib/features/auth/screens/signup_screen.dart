import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/common/widgets/forms/text_input_form.dart';
import 'package:prayer/features/user/widgets/forms/username_input_form.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';

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

    final onSubmit = useCallback(() async {
      if (formKey.currentState?.saveAndValidate() == true) {
        loading.value = true;
        final form = formKey.currentState!.value;
        try {
          await ref.read(authNotifierProvider.notifier).createUser(
                username: form['username'],
                name: FirebaseAuth.instance.currentUser?.displayName ?? '',
                bio: form['bio'],
              );
        } on DuplicatedUsernameException catch (_) {
          GlobalSnackBar.show(context,
              message: S.of(context).errorUsernameTaken(form['username']));
        } catch (e) {
          GlobalSnackBar.show(context, message: e.toString());
        } finally {
          loading.value = false;
        }
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
            S.of(context).profile,
            style: const TextStyle(color: MyTheme.onPrimary),
          ),
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
            child: ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Text(
                        S.of(context).signUpScreenBibleVerse,
                        style: TextStyle(
                          fontSize: 14,
                          color: MyTheme.outline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        S.of(context).signUpScreenBibleVerseBook,
                        style: TextStyle(
                          fontSize: 12,
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
          ),
        ),
      ),
    );
  }
}
