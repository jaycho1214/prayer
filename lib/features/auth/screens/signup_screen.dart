import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/errors.dart';

import 'package:prayer/i18n/strings.g.dart';
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
              message: t.error.usernameTaken(username: form['username']));
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

    return KeyboardDismissOnTap(
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          cupertino: (context, platform) => CupertinoNavigationBarData(
              backgroundColor: Theme.of(context).colorScheme.background),
          title: Text(
            t.general.profile,
          ),
          trailingActions: [
            Center(
              child: PrimaryTextButton(
                text: t.general.done,
                onTap: onSubmit,
                loading: loading.value,
              ),
            ),
          ],
        ),
        body: FormBuilder(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Text(
                      t.auth.signup.bible.passage,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      t.auth.signup.bible.verse,
                      style: Theme.of(context).textTheme.labelSmall,
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
                      labelText: t.general.bio,
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
    );
  }
}
