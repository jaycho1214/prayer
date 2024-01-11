import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/settings/donation/sheets/donation_detail_sheet.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        automaticallyImplyLeading: false,
        title: Text(t.donate.title),
        cupertino: (context, platform) => CupertinoNavigationBarData(
            backgroundColor: Theme.of(context).colorScheme.background),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/jesus.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                t.donate.message,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          ShrinkingButton(
            onTap: () async {
              mixpanel.track("Donate Clicked");
              if (Localizations.localeOf(context).languageCode == 'ko') {
                DonationDetailSheet.show(context);
              } else {
                launchUrl(
                  Uri.parse('https://paypal.me/PrayerOfficial'),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  t.donate.title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 30),
        ],
      ),
    );
  }
}
