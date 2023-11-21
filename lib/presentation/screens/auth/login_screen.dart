import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/auth/login_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/providers/auth/auth_provider.dart';
import 'package:prayer/providers/auth/auth_state.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authNotifierProvider.notifier);
    final loading = ref.watch(authNotifierProvider).isLoading;
    final lastPressed = useState<String?>(null);

    ref.listen(authNotifierProvider, (_, next) {
      if (next.error != null) {}
      next.when(
          data: (state) {
            if (state is AuthStateSignedIn) {
              context.go('/auth/signUp');
            } else if (state is AuthStateSignedUp) {
              context.go('/');
            }
          },
          error: (_, __) {
            GlobalSnackBar.show(
              context,
              message: "Failed to sign in. Please try again.",
            );
          },
          loading: () => null);
    });

    return Container(
      color: MyTheme.surface,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.fromLTRB(20, 80 + MediaQuery.of(context).padding.top,
          20, MediaQuery.of(context).padding.bottom + 40),
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
              LoginButton(
                iconPath: "assets/images/logo/x.png",
                text: "Continue with X",
                onTap: () {
                  lastPressed.value = 'x';
                },
              ),
              if (Platform.isIOS) ...[
                const SizedBox(height: 10),
                LoginButton(
                    loading: lastPressed.value == 'apple' && loading,
                    iconPath: "assets/images/logo/apple.png",
                    text: "Continue with Apple",
                    onTap: () {
                      lastPressed.value = 'apple';
                      authProvider.signIn(AuthProvider.apple);
                    }),
              ],
              const SizedBox(height: 10),
              LoginButton(
                  loading: lastPressed.value == 'google' && loading,
                  iconPath: "assets/images/logo/google.png",
                  text: "Continue with Google",
                  onTap: () {
                    lastPressed.value = 'google';
                    authProvider.signIn(AuthProvider.google);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
