import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

enum CorporatePrayerDurationStatus { preparing, praying, prayed }

class CorporatePrayerDuration extends StatelessWidget {
  const CorporatePrayerDuration({
    super.key,
    required this.status,
    this.startedAt,
    this.endedAt,
    this.prayersCount = 0,
  });

  final CorporatePrayerDurationStatus status;
  final Jiffy? startedAt;
  final Jiffy? endedAt;
  final int prayersCount;

  static Future<bool?> show(
    BuildContext context, {
    required CorporatePrayerDurationStatus status,
    Jiffy? startedAt,
    Jiffy? endedAt,
    int prayersCount = 0,
  }) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return CorporatePrayerDuration(
            status: status,
            startedAt: startedAt,
            endedAt: endedAt,
            prayersCount: prayersCount,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              switch (status) {
                CorporatePrayerDurationStatus.prayed =>
                  S.of(context).corporatePrayerPrayed,
                CorporatePrayerDurationStatus.praying =>
                  S.of(context).corporatePrayerPraying,
                CorporatePrayerDurationStatus.preparing =>
                  S.of(context).corporatePrayerPreparing,
              },
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  if (startedAt != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(startedAt!.yMMMd),
                    ),
                    Expanded(child: Divider()),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FaIcon(
                      FontAwesomeIcons.handsPraying,
                      color: MyTheme.onPrimary,
                      size: 15,
                    ),
                  ),
                  if (endedAt != null) ...[
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(endedAt!.yMMMd),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$prayersCount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' ${S.of(context).prayers}'),
                    if (endedAt != null) ...[
                      TextSpan(text: ', '),
                      TextSpan(
                        text:
                            '${endedAt!.diff(Jiffy.now(), unit: Unit.day)} days',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ShrinkingButton(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: double.infinity,
                height: 50,
                child: Icon(
                  FontAwesomeIcons.xmark,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
