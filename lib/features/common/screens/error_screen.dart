import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/i18n/strings.g.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        cupertino: (context, platform) => CupertinoNavigationBarData(
            backgroundColor: Theme.of(context).colorScheme.background),
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
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                t.error.connection.title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(t.error.connection.description),
              const SizedBox(height: 20),
              PrimaryTextButton(
                text: t.general.refresh,
                onTap: () => ref.refresh(authNotifierProvider.future),
              ),
              SizedBox(height: 10),
              PrimaryTextButton(
                text: t.general.signOut,
                onTap: () => ref.read(authNotifierProvider.notifier).signOut(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
