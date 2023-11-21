import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/presentation/widgets/chip/statistics_chip.dart';
import 'package:prayer/presentation/widgets/form/sheet/too_many_pray_sheet.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/prayer_repository.dart';

class PrayChip extends HookWidget {
  const PrayChip({
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
      GetIt.I<PrayerRepository>()
          .createPrayerPray(prayerId: prayerId)
          .then((value) {
        if (value) {
          prayed.value = true;
          newValue.value += 1;
        } else {
          TooManyPraySheet.show(context);
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
    return StatisticsChip(
      onTap: onTap,
      icon: FontAwesomeIcons.lightHandsPraying,
      inverted: prayed.value,
      value: newValue.value,
    );
  }
}
