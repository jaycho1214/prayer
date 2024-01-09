import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationDetailSheet extends HookWidget {
  const DonationDetailSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      elevation: 0,
      context: context,
      builder: (context) => DonationDetailSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final copied = useState(false);
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(
        10,
        10,
        10,
        MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.solidHeart,
                size: 20,
                color: Colors.red,
              ),
              const SizedBox(height: 10),
              Text(
                S.of(context).donatePrayer,
                style: Theme.of(context).textTheme.displaySmall,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "은행을 통해 후원하기",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          ShrinkingButton(
            onTap: () {
              Clipboard.setData(ClipboardData(text: '토스뱅크 1000-8509-8221'));
              HapticFeedback.mediumImpact();
              copied.value = true;
              Future.delayed(const Duration(milliseconds: 500), () {
                copied.value = false;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "토스뱅크 1000-8509-8221",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: copied.value
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: FaIcon(
                    FontAwesomeIcons.copy,
                    size: 12,
                  ),
                  secondChild: FaIcon(
                    FontAwesomeIcons.check,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Paypal 통해 후원하기",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SelectableText(
            "https://paypal.me/PrayerOfficial",
            style: TextStyle(fontWeight: FontWeight.bold),
            onTap: () {
              launchUrl(
                Uri.parse('https://paypal.me/PrayerOfficial'),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ShrinkingButton(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
