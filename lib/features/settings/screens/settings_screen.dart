import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prayer/features/settings/widgets/donate_card.dart';
import 'package:prayer/features/settings/widgets/settings_row_card.dart';
import 'package:prayer/features/settings/widgets/settings_switch_card.dart';

import 'package:prayer/i18n/strings.g.dart';
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

    return Scaffold(
      appBar: AppBar(
        leading: NavigateBackButton(),
        title: Text(
          t.general.settings,
          style: platformThemeData(
            context,
            material: (ThemeData data) => data.textTheme.headlineSmall,
            cupertino: (data) => data.textTheme.navTitleTextStyle
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            if (bannedAt != null) AccountBanCard(),
            const SizedBox(height: 20),
            DonateCard(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "UI",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: Hive.box('settings').listenable(keys: ['theme']),
              builder: (context, box, _) {
                return SettingsSwitchCard(
                  icon: FontAwesomeIcons.solidMoon,
                  title: t.general.darkMode,
                  value: box.get('theme') == 'dark',
                  onTap: () {
                    final theme = box.get('theme');
                    box.put('theme', theme == 'dark' ? 'light' : 'dark');
                  },
                );
              },
            ),
            const Divider(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                t.general.account,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SettingsRowCard(
              icon: FontAwesomeIcons.user,
              title: t.general.account,
              onTap: () {
                context.push('/settings/account');
              },
            ),
            const Divider(),
            SettingsRowCard(
              icon: FontAwesomeIcons.lightAlarmClock,
              title: t.general.reminder,
              onTap: () {
                context.push('/settings/reminders');
              },
            ),
            const Divider(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                t.general.support,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SettingsRowCard(
              icon: FontAwesomeIcons.arrowUpRightFromSquare,
              title: t.general.sharePrayer,
              onTap: () {
                Share.share(t.settings.shareAppMessage(
                    url: Platform.isIOS
                        ? 'https://apps.apple.com/app/prayer-united-in-prayer/id6471775802'
                        : 'https://play.google.com/store/apps/details?id=com.crosswand.prayer'));
              },
            ),
            const Divider(),
            SettingsRowCard(
              icon: FontAwesomeIcons.comment,
              title: t.general.sendFeedback,
              onTap: () {
                FeedbackForm.show(context);
              },
            ),
            const Divider(),
            SettingsRowCard(
              icon: FontAwesomeIcons.lightMessagePen,
              title: t.general.ratePrayer,
              onTap: () {
                launchUrl(Uri.parse(
                  Platform.isIOS
                      ? 'itms-apps://apps.apple.com/us/app/prayer-united-in-prayer/id6471775802?action=write-review'
                      : 'https://play.google.com/store/apps/details?id=com.crosswand.prayer',
                ));
              },
            ),
            const Divider(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                t.general.legal,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SettingsRowCard(
              icon: FontAwesomeIcons.blinds,
              title: t.general.privacyPolicy,
              onTap: () {
                launchUrl(
                    Uri.parse('https://www.crosswand.com/app/prayer/privacy'));
              },
            ),
            const Divider(),
            SettingsRowCard(
              icon: FontAwesomeIcons.file,
              title: t.general.termsOfUse,
              onTap: () {
                launchUrl(
                    Uri.parse('https://www.crosswand.com/app/prayer/terms'));
              },
            ),
            const Divider(),
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
                  return Text.rich(
                    t.settings.versionText(
                      version: TextSpan(
                        text: text,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: Theme.of(context).textTheme.labelMedium,
                  );
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
