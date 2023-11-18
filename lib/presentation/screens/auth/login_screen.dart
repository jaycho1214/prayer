import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';
import 'package:prayer/bloc/auth/authentication_event.dart';
import 'package:prayer/bloc/auth/authentication_state.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/auth/login_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) => switch (state) {
        AuthenticationStateSignedIn() => context.go('/auth/signUp'),
        AuthenticationStateSignedUp() => context.go('/'),
        AuthenticationStateSignInError() => GlobalSnackBar.show(
            context,
            message: "Failed to sign in. Please try again.",
          ),
        _ => null,
      },
      child: Container(
        color: MyTheme.surface,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.fromLTRB(
            20,
            80 + MediaQuery.of(context).padding.top,
            20,
            MediaQuery.of(context).padding.bottom + 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "United in Prayer\nStronger Together\nCollective Faith",
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: MyTheme.onPrimary,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginButton(
                  iconPath: "assets/images/logo/x.png",
                  text: "Continue with X",
                ),
                if (Platform.isIOS) ...[
                  const SizedBox(height: 10),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) => LoginButton(
                        loading: state ==
                            AuthenticationState.signInLoading(
                                AuthenticationProvider.apple),
                        iconPath: "assets/images/logo/apple.png",
                        text: "Continue with Apple",
                        onTap: () {
                          context.read<AuthenticationBloc>().add(
                                AuthenticationEvent.signIn(
                                    AuthenticationProvider.apple),
                              );
                        }),
                  ),
                ],
                const SizedBox(height: 10),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) => LoginButton(
                      loading: state ==
                          AuthenticationState.signInLoading(
                              AuthenticationProvider.google),
                      iconPath: "assets/images/logo/google.png",
                      text: "Continue with Google",
                      onTap: () {
                        context.read<AuthenticationBloc>().add(
                              AuthenticationEvent.signIn(
                                  AuthenticationProvider.google),
                            );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
