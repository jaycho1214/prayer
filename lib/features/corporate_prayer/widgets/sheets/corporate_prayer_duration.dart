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
  });

  final CorporatePrayerDurationStatus status;
  final Jiffy? startedAt;
  final Jiffy? endedAt;

  static Future<bool?> show(
    BuildContext context, {
    required CorporatePrayerDurationStatus status,
    Jiffy? startedAt,
    Jiffy? endedAt,
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
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
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
            const SizedBox(height: 20),
            Expanded(
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
            const SizedBox(height: 20),
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
