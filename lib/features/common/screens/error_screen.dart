import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        backgroundColor: MyTheme.surface,
        automaticallyImplyLeading: false,
        title: Text(
          "Prayer",
          style: platformThemeData(
            context,
            material: (ThemeData data) => data.textTheme.headlineSmall,
            cupertino: (data) => data.textTheme.navTitleTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(
                FontAwesomeIcons.thinCircleExclamation,
                color: MyTheme.onPrimary,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                S.of(context).errorConnection,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                S.of(context).errorConnectionDescription,
              ),
              SizedBox(height: 20),
              PrimaryTextButton(
                text: S.of(context).refresh,
                onTap: () => ref.refresh(authNotifierProvider.future),
              ),
              SizedBox(height: 10),
              PrimaryTextButton(
                text: S.of(context).signOut,
                onTap: () => ref.read(authNotifierProvider.notifier).signOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
