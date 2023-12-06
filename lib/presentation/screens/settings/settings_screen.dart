import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/form/sheet/feedback_form.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  Widget _buildRow({
    required IconData icon,
    required String title,
    String? description,
    void Function()? onTap,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: FaIcon(
                icon,
                color: MyTheme.placeholderText,
                size: 15,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: MyTheme.placeholderText,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: MyTheme.onPrimary,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        backgroundColor: MyTheme.surface,
        title: Text(S.of(context).settings),
      ),
      body: ListView(
        children: [
          _buildRow(
            icon: FontAwesomeIcons.boxHeart,
            title: S.of(context).donatePrayer,
            onTap: () {
              context.push('/settings/donate');
            },
          ),
          const Divider(color: MyTheme.disabled),
          _buildRow(
            icon: FontAwesomeIcons.user,
            title: S.of(context).account,
            onTap: () {
              context.push('/settings/account');
            },
          ),
          const Divider(color: MyTheme.disabled),
          _buildRow(
            icon: FontAwesomeIcons.arrowUpRightFromSquare,
            title: S.of(context).sharePrayer,
            onTap: () {
              Share.share(S.of(context).shareAppMessage(Platform.isIOS
                  ? 'https://apps.apple.com/app/prayer-united-in-prayer/id6471775802'
                  : 'https://play.google.com/store/apps/details?id=com.crosswand.prayer'));
            },
          ),
          _buildRow(
            icon: FontAwesomeIcons.comment,
            title: S.of(context).sendFeedback,
            onTap: () {
              FeedbackForm.show(context);
            },
          ),
          _buildRow(
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
          _buildRow(
            icon: FontAwesomeIcons.blinds,
            title: S.of(context).privacyPolicy,
            onTap: () {
              launchUrl(
                  Uri.parse('https://www.crosswand.com/app/prayer/privacy'));
            },
          ),
          _buildRow(
            icon: FontAwesomeIcons.file,
            title: S.of(context).termsOfUse,
            onTap: () {
              launchUrl(
                  Uri.parse('https://www.crosswand.com/app/prayer/terms'));
            },
          ),
          const Divider(color: MyTheme.disabled),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
    );
  }
}
