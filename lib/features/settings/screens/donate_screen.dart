import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/settings/donation/sheets/donation_detail_sheet.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        leading: NavigateBackButton(),
        automaticallyImplyLeading: false,
        backgroundColor: MyTheme.surface,
        title: Text(S.of(context).donatePrayer),
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
                S.of(context).descriptionNeedDonation,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: MyTheme.placeholderText,
                  fontSize: 15,
                ),
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
                color: MyTheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  S.of(context).donatePrayer,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: MyTheme.surface,
                    fontSize: 15,
                  ),
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
