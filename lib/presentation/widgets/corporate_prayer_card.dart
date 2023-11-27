import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/chip/statistics_chip.dart';
import 'package:prayer/presentation/widgets/chip/text_chip.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CorporatePrayerCard extends HookWidget {
  const CorporatePrayerCard({
    super.key,
    required this.prayerId,
    this.onTap,
  });

  final void Function()? onTap;
  final String prayerId;

  @override
  Widget build(BuildContext context) {
    final prayerSnapshot = useFuture(useMemoized(
        () => GetIt.I<PrayerRepository>().fetchCorporatePrayer(prayerId)));

    return Skeletonizer(
      enabled: prayerSnapshot.connectionState == ConnectionState.waiting,
      child: ShrinkingButton(
        onTap: () {
          if (onTap == null) {
            context.push('/prayers/corporate/$prayerId');
          } else {
            onTap!.call();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prayerSnapshot.data?.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          prayerSnapshot.data?.description ?? '',
                          style: const TextStyle(
                            color: MyTheme.outline,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  UserChip(
                    uid: prayerSnapshot.data?.userId,
                    profile: prayerSnapshot.data?.user?.profile,
                    name: prayerSnapshot.data?.user?.name,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (prayerSnapshot.data?.startedAt != null)
                    TextChip(
                        icon: FontAwesomeIcons.calendarDays,
                        value:
                            '${Jiffy.parseFromDateTime(prayerSnapshot.data!.startedAt!.toLocal()).yMMMd}${prayerSnapshot.data?.endedAt == null ? "" : "-${Jiffy.parseFromDateTime(prayerSnapshot.data!.endedAt!.toLocal()).yMMMd}"}'),
                  Spacer(),
                  StatisticsChip(
                    icon: FontAwesomeIcons.personPraying,
                    value: prayerSnapshot.data?.prayersCount ?? 0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
