import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/settings/widgets/donate_card.dart';
import 'package:prayer/features/settings/widgets/settings_row_card.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/sheets/feedback_form.dart';
import 'package:prayer/features/user/widgets/account_ban_card.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannedAt = ref.watch(authNotifierProvider).valueOrNull?.when(
          signedOut: () => null,
          signedIn: () => null,
          signedUp: (user) => user.bannedAt,
        );

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        backgroundColor: MyTheme.surface,
        title: Text(S.of(context).settings),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            if (bannedAt != null) AccountBanCard(),
            const SizedBox(height: 20),
            DonateCard(),
            const SizedBox(height: 20),
            SettingsRowCard(
              icon: FontAwesomeIcons.user,
              title: S.of(context).account,
              onTap: () {
                context.push('/settings/account');
              },
            ),
            const Divider(color: MyTheme.disabled),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                S.of(context).support,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SettingsRowCard(
              icon: FontAwesomeIcons.arrowUpRightFromSquare,
              title: S.of(context).sharePrayer,
              onTap: () {
                Share.share(S.of(context).shareAppMessage(Platform.isIOS
                    ? 'https://apps.apple.com/app/prayer-united-in-prayer/id6471775802'
                    : 'https://play.google.com/store/apps/details?id=com.crosswand.prayer'));
              },
            ),
            const Divider(color: MyTheme.disabled),
            SettingsRowCard(
              icon: FontAwesomeIcons.comment,
              title: S.of(context).sendFeedback,
              onTap: () {
                FeedbackForm.show(context);
              },
            ),
            const Divider(color: MyTheme.disabled),
            SettingsRowCard(
              icon: FontAwesomeIcons.lightMessagePen,
              title: S.of(context).ratePrayer,
              onTap: () {
                launchUrl(Uri.parse(
                  Platform.isIOS
                      ? 'itms-apps://apps.apple.com/us/app/prayer-united-in-prayer/id6471775802?action=write-review'
                      : 'https://play.google.com/store/apps/details?id=com.crosswand.prayer',
                ));
              },
            ),
            const Divider(color: MyTheme.disabled),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                S.of(context).legal,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SettingsRowCard(
              icon: FontAwesomeIcons.blinds,
              title: S.of(context).privacyPolicy,
              onTap: () {
                launchUrl(
                    Uri.parse('https://www.crosswand.com/app/prayer/privacy'));
              },
            ),
            const Divider(color: MyTheme.disabled),
            SettingsRowCard(
              icon: FontAwesomeIcons.file,
              title: S.of(context).termsOfUse,
              onTap: () {
                launchUrl(
                    Uri.parse('https://www.crosswand.com/app/prayer/terms'));
              },
            ),
            const Divider(color: MyTheme.disabled),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  String text = '';
                  if (snapshot.data != null) {
                    text = Platform.isAndroid
                        ? '${snapshot.data!.version}, ${snapshot.data!.buildNumber}'
                        : '${snapshot.data!.version}+${snapshot.data!.buildNumber}';
                  }
                  return Text(
                    S.of(context).versionText(text),
                    style: TextStyle(color: MyTheme.outline),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
