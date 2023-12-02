import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationDetailSheet extends HookWidget {
  const DonationDetailSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => DonationDetailSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final copied = useState(false);
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).padding.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: MyTheme.sheetSurface,
        ),
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.solidHeart,
              size: 20,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).donatePrayer,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "은행을 통해 후원하기",
                      style: TextStyle(
                        color: MyTheme.placeholderText,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SelectableText(
                          "토스뱅크 1000-8509-8221",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: '토스뱅크 1000-8509-8221'));
                            HapticFeedback.mediumImpact();
                            copied.value = true;
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              copied.value = false;
                            });
                          },
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
                            color: MyTheme.placeholderText,
                          ),
                          secondChild: FaIcon(
                            FontAwesomeIcons.check,
                            size: 12,
                            color: MyTheme.placeholderText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Paypal 통해 후원하기",
                      style: TextStyle(
                        color: MyTheme.placeholderText,
                        fontSize: 12,
                      ),
                    ),
                    SelectableText(
                      "https://paypal.me/PrayerOfficial",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      onTap: () {
                        launchUrl(
                            Uri.parse('https://paypal.me/PrayerOfficial'));
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ShrinkingButton(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
