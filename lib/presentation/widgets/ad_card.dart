import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AdCard extends HookWidget {
  const AdCard({super.key});

  @override
  Widget build(BuildContext context) {
    final adFormat = useState<AdFormat?>(AdFormat.mrec);

    if (adFormat.value == null) {
      return SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: double.infinity, height: 10),
          Row(
            children: [
              UserChip(
                name: 'Ads',
              ),
              Spacer(),
              Text(
                "Now",
                style: TextStyle(color: MyTheme.outline),
              ),
            ],
          ),
          Center(
            child: MaxAdView(
              adUnitId: Platform.isIOS
                  ? dotenv.env['BANNER_IOS_AD_UNIT_ID']!
                  : dotenv.env['BANNER_ANDROID_AD_UNIT_ID']!,
              adFormat: adFormat.value!,
              listener: AdViewAdListener(
                onAdLoadedCallback: (_) => null,
                onAdLoadFailedCallback: (_, error) {
                  Sentry.captureException(error);
                  adFormat.value = adFormat.value == AdFormat.banner
                      ? null
                      : AdFormat.banner;
                },
                onAdClickedCallback: (ad) {
                  mixpanel.track('Click Ads');
                },
                onAdExpandedCallback: (_) => null,
                onAdCollapsedCallback: (_) => null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
