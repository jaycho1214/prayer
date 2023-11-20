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
    this.loading = false,
    this.hasPrayed = false,
    this.silent = false,
    this.onPray,
  });

  final String prayerId;
  final int value;
  final bool hasPrayed;
  final bool loading;
  final bool silent;
  final void Function()? onPray;

  Widget buildIndicator(BuildContext context) {
    return Center(
      child: PlatformCircularProgressIndicator(
        cupertino: (context, target) => CupertinoProgressIndicatorData(
            color: hasPrayed ? MyTheme.surface : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _loading = useState(loading);

    useEffect(() {
      _loading.value = loading;

      return () => null;
    }, [loading]);

    final onTap = useCallback(() async {
      _loading.value = true;
      context
          .read<PrayerRepository>()
          .createPrayerPray(prayerId: prayerId)
          .then((value) {
        if (value) {
          onPray?.call();
        } else {
          PrayerPrayConfirmForm.show(context);
        }
      }).catchError((e) {
        talker.error("Error while praying for the post", e);
        GlobalSnackBar.show(context, message: "Failed to like the post");
      }).whenComplete(() {
        _loading.value = false;
      });
    }, []);

    if (silent) {
      return ShrinkingButton(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          decoration: BoxDecoration(
            color: hasPrayed ? MyTheme.onPrimary : MyTheme.surfaceDim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _loading.value
              ? buildIndicator(context)
              : FaIcon(
                  FontAwesomeIcons.lightHandsPraying,
                  color: hasPrayed ? MyTheme.surface : MyTheme.onPrimary,
                  size: 15,
                ),
        ),
      );
    }
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: hasPrayed ? MyTheme.onPrimary : MyTheme.surfaceDim,
          borderRadius: BorderRadius.circular(10),
        ),
        child: _loading.value
            ? buildIndicator(context)
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
                    "Pray with Words",
                    style: TextStyle(
                      fontSize: 15,
                      color: hasPrayed ? MyTheme.surface : MyTheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    Formatter.formatNumber(value),
                    style: TextStyle(
                      fontSize: 15,
                      color: hasPrayed ? MyTheme.surface : MyTheme.onPrimary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
