import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/pray/widgets/forms/pray_with_word_form.dart';
import 'package:prayer/features/pray/sheets/too_many_pray_sheet.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';

class PrayButton extends HookConsumerWidget {
  const PrayButton({
    super.key,
    required this.prayerId,
    this.onPrayed,
  });

  final String prayerId;
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

    final onTap = useCallback(
        (bool silent) => () async {
              String? value;
              if (!silent) {
                value =
                    await PrayWithWordForm.show(context, prayerId: prayerId);
                if (value == null) {
                  return;
                }
              }
              prayerNotifier.prayForUser(
                  value: value,
                  onPrayed: () {
                    onPrayed?.call();
                    mixpanel.track("Pray Sent");
                  },
                  onError: () {
                    GlobalSnackBar.show(context,
                        message: S.of(context).errorUnknown);
                  },
                  onNeedWait: () {
                    mixpanel.track("Pray Need Wait");
                    TooManyPraySheet.show(context);
                  });
            },
        []);

    return Container(
      height: 60,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyTheme.surfaceDim,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ShrinkingButton(
                onTap: onTap(true),
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 85,
                  child: FaIcon(
                    hasPrayed
                        ? FontAwesomeIcons.solidFireFlameCurved
                        : FontAwesomeIcons.lightFireFlameCurved,
                    color: hasPrayed ? Colors.red : MyTheme.placeholderText,
                  ),
                ),
              ),
              ShrinkingButton(
                onTap: onTap(false),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyTheme.onPrimary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: FaIcon(
                    FontAwesomeIcons.messageHeart,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
