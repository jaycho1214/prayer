import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/form/sheet/prayer_pray_confirm.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/utils/formatter.dart';

class PrayButton extends HookWidget {
  const PrayButton({
    super.key,
    required this.prayerId,
    required this.value,
    this.hasPrayed = false,
  });

  final String prayerId;
  final int value;
  final bool hasPrayed;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    final newValue = useState(value);
    final prayed = useState(hasPrayed);

    final onTap = useCallback(() async {
      loading.value = true;
      context
          .read<PrayerRepository>()
          .createPrayerPray(prayerId: prayerId)
          .then((value) {
        if (value) {
          prayed.value = true;
          newValue.value += 1;
        } else {
          PrayerPrayConfirmForm.show(context);
        }
      }).catchError((e) {
        talker.error("Error while praying for the post", e);
        GlobalSnackBar.show(context, message: "Failed to like the post");
      }).whenComplete(() {
        loading.value = false;
      });
    }, []);

    if (loading.value) {
      return PlatformCircularProgressIndicator();
    }
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: prayed.value ? MyTheme.onPrimary : MyTheme.surfaceDim,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.lightHandsPraying,
              color: prayed.value ? MyTheme.surface : MyTheme.onPrimary,
              size: 15,
            ),
            const SizedBox(width: 5),
            Text(
              "Pray",
              style: TextStyle(
                fontSize: 15,
                color: prayed.value ? MyTheme.surface : MyTheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              Formatter.formatNumber(newValue.value),
              style: TextStyle(
                fontSize: 15,
                color: prayed.value ? MyTheme.surface : MyTheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
