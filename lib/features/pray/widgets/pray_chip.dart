import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/pray/sheets/too_many_pray_sheet.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';

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

    return ShrinkingButton(
      onTap: () {
        prayerNotifier.prayForUser(
          onPrayed: () => ref.refresh(PrayerNotifierProvider(prayerId).future),
          onError: () {
            mixpanel.track("Pray Sent");
            GlobalSnackBar.show(context, message: t.error.unknown);
          },
          onNeedWait: () {
            mixpanel.track("Pray Need Wait");
            TooManyPraySheet.show(context);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: prayer.value?.hasPrayed == null
              ? Colors.transparent
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Text(
          t.general.pray,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: prayer.value?.hasPrayed == null
                  ? Theme.of(context).colorScheme.onBackground
                  : Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
