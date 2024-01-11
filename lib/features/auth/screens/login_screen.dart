import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/auth/widgets/login_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/features/auth/providers/auth_state.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({
    super.key,
    this.needSignOut = false,
  });

  final bool needSignOut;

  Widget _buildDisclaimer(BuildContext context) {
    return Text.rich(
      t.auth.login.disclaimer(
        termsOfService: TextSpan(
          text: t.general.termsOfUse,
          style: TextStyle(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(
                Uri.parse('https://www.crosswand.com/app/prayer/terms')),
        ),
        privacyPolicy: TextSpan(
          text: t.general.privacyPolicy,
          style: TextStyle(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(
                Uri.parse('https://www.crosswand.com/app/prayer/privacy')),
        ),
      ),
      style: Theme.of(context).textTheme.labelMedium,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authNotifierProvider.notifier);
    final loading = ref.watch(authNotifierProvider).isLoading;
    final lastPressed = useState<String?>(null);

    ref.listen(authNotifierProvider, (_, next) {
      next.when(
        data: (state) => state is AuthStateSignedIn
            ? context.go('/auth/signUp')
            : context.go('/'),
        error: (_, __) => GlobalSnackBar.show(context, message: t.error.signIn),
        loading: () => null,
      );
    });

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (needSignOut) {
          ref.read(authNotifierProvider.notifier).signOut();
        }
      });

      return () => null;
    }, [needSignOut]);

    return Container(
      color: Theme.of(context).colorScheme.background,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.fromLTRB(20, 60 + MediaQuery.of(context).padding.top,
          20, MediaQuery.of(context).padding.bottom + 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.introduction.title.join('\n'),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (Platform.isIOS) ...[
                const SizedBox(height: 10),
                LoginButton(
                  loading: lastPressed.value == 'apple' && loading,
                  iconPath: "assets/images/logo/apple.png",
                  text: t.auth.login.button.apple,
                  onTap: () {
                    lastPressed.value = 'apple';
                    authProvider.signIn(AuthProvider.apple);
                  },
                  imageColor: Theme.of(context).colorScheme.onBackground,
                ),
              ],
              const SizedBox(height: 10),
              LoginButton(
                loading: lastPressed.value == 'google' && loading,
                iconPath: "assets/images/logo/google.png",
                text: t.auth.login.button.google,
                onTap: () {
                  lastPressed.value = 'google';
                  authProvider.signIn(AuthProvider.google);
                },
              ),
              const SizedBox(height: 20),
              _buildDisclaimer(context),
            ],
          ),
        ],
      ),
    );
  }
}
