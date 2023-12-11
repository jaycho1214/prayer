import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/form/sheet/pray_with_word_form.dart';
import 'package:prayer/presentation/widgets/sheets/too_many_pray_sheet.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/providers/prayer/prayer_provider.dart';
import 'package:prayer/utils/formatter.dart';

class PrayButton extends ConsumerWidget {
  const PrayButton({
    super.key,
    required this.prayerId,
    this.silent = false,
    this.onPrayed,
  });

  final String prayerId;
  final bool silent;
  final void Function()? onPrayed;

  Widget buildIndicator(BuildContext context, bool hasPrayed) {
    return Center(
      child: PlatformCircularProgressIndicator(
        cupertino: (context, target) => CupertinoProgressIndicatorData(
            color: hasPrayed ? MyTheme.surface : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerNotifierProvider(prayerId));
    final prayerNotifier = ref.watch(prayerNotifierProvider(prayerId).notifier);
    final hasPrayed = prayer.value?.hasPrayed != null;

    return ShrinkingButton(
      onTap: () async {
        String? value;
        if (!silent) {
          value = await PrayWithWordForm.show(context, prayerId: prayerId);
          if (value == null) {
            return;
          }
        }
        prayerNotifier.prayForUser(
            value: value,
            onPrayed: onPrayed,
            onError: () {
              GlobalSnackBar.show(context, message: "Failed to ");
            },
            onNeedWait: () {
              TooManyPraySheet.show(context);
            });
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 25, vertical: silent ? 18 : 15),
        decoration: BoxDecoration(
          color: hasPrayed ? MyTheme.onPrimary : MyTheme.surfaceDim,
          borderRadius: BorderRadius.circular(10),
        ),
        child: prayer.isLoading
            ? buildIndicator(context, hasPrayed)
            : silent
                ? FaIcon(
                    FontAwesomeIcons.lightHandsPraying,
                    color: hasPrayed ? MyTheme.surface : MyTheme.onPrimary,
                    size: 15,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.personPraying,
                        color: hasPrayed ? MyTheme.surface : MyTheme.onPrimary,
                        size: 15,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        S.of(context).prayWithWords,
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              hasPrayed ? MyTheme.surface : MyTheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Formatter.formatNumber(prayer.value?.praysCount ?? 0),
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              hasPrayed ? MyTheme.surface : MyTheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
