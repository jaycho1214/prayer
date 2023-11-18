import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
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
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            FaIcon(
              icon,
              color: MyTheme.onPrimary,
              size: 15,
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
                        color: MyTheme.outline,
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
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          _buildRow(
            icon: FontAwesomeIcons.lockOpen,
            title: "Sign Out",
            onTap: () {
              while (context.canPop()) {
                context.pop();
              }
              context.push('/auth/signIn');
              FirebaseAuth.instance.signOut();
            },
          ),
          _buildRow(
            icon: FontAwesomeIcons.blinds,
            title: "Privacy Policy",
            onTap: () {
              launchUrl(
                  Uri.parse('https://www.crosswand.com/app/prayer/privacy'));
            },
          ),
          _buildRow(
            icon: FontAwesomeIcons.file,
            title: "Terms of Use",
            onTap: () {
              launchUrl(
                  Uri.parse('https://www.crosswand.com/app/prayer/terms'));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
                  "Version: $text",
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
