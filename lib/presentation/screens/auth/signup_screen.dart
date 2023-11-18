import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';
import 'package:prayer/bloc/auth/authentication_event.dart';
import 'package:prayer/bloc/auth/authentication_state.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/text_input_form.dart';
import 'package:prayer/presentation/widgets/form/username_input_form.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    final onSubmit = useCallback(() {
      try {
        if (formKey.currentState?.saveAndValidate() == true) {
          final form = formKey.currentState!.value;
          context.read<AuthenticationBloc>().add(AuthenticationEvent.signUp(
                username: form['username'],
                name: form['name'],
                bio: form['bio'],
              ));
        }
      } catch (e) {
        GlobalSnackBar.show(context, message: e.toString());
      }
    }, [
      context,
      formKey,
    ]);

    useEffect(() {
      final subscription =
          context.read<AuthenticationBloc>().stream.listen((event) {
        if (event is AuthenticationStateSignUpError) {
          GlobalSnackBar.show(context, message: event.message);
        }
        if (event is AuthenticationStateSignedUp) {
          context.go('/');
        }
      });
      return subscription.cancel;
    }, []);

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
