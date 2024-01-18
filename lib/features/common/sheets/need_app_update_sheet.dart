import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prayer/features/common/widgets/buttons/large_text_button.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedAppUpdateSheet extends StatelessWidget {
  const NeedAppUpdateSheet({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      elevation: 0,
      context: context,
      isScrollControlled: false,
      builder: (context) => NeedAppUpdateSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom + 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/logo/icon.png',
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            t.alert.update.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 5),
          Text(
            t.alert.update.description,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          LargeTextButton(
            text: t.alert.update.button,
            onTap: () {
              launchUrl(Uri.parse(
                Platform.isIOS
                    ? 'itms-apps://apps.apple.com/us/app/prayer-united-in-prayer/id6471775802'
                    : 'https://play.google.com/store/apps/details?id=com.crosswand.prayer',
              ));
            },
          ),
        ],
      ),
    );
  }
}
