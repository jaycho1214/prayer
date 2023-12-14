import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/chip/statistics_chip.dart';
import 'package:prayer/presentation/widgets/sheets/too_many_pray_sheet.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/providers/prayer/prayer_provider.dart';

class PrayChip extends ConsumerWidget {
  const PrayChip({
    super.key,
    required this.prayerId,
  });

  final String prayerId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerNotifierProvider(prayerId));
    final prayerNotifier = ref.watch(prayerNotifierProvider(prayerId).notifier);

    return StatisticsChip(
      onTap: () {
        prayerNotifier.prayForUser(onError: () {
          mixpanel.track("Pray Sent");
          GlobalSnackBar.show(context, message: S.of(context).errorUnknown);
        }, onNeedWait: () {
          mixpanel.track("Pray Need Wait");
          TooManyPraySheet.show(context);
        });
      },
      loading: prayer.isLoading,
      icon: FontAwesomeIcons.solidFireFlameCurved,
      inverted: prayer.value?.hasPrayed != null,
      value: prayer.value?.praysCount ?? 0,
    );
  }
}
