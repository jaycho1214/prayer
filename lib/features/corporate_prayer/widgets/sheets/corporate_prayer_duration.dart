import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';

import 'package:prayer/i18n/strings.g.dart';

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
      padding: EdgeInsets.fromLTRB(
        20,
        10,
        20,
        MediaQuery.of(context).padding.bottom + 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            switch (status) {
              CorporatePrayerDurationStatus.prayed =>
                t.general.corporatePrayerPrayed,
              CorporatePrayerDurationStatus.praying =>
                t.general.corporatePrayerPraying,
              CorporatePrayerDurationStatus.preparing =>
                t.general.corporatePrayerPreparing,
            },
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$prayersCount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' ${t.general.prayers}'),
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
          LargeIconButton(
            icon: FontAwesomeIcons.xmark,
            onTap: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
