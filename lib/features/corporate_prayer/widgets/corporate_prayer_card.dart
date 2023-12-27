import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/chips/statistics_chip.dart';
import 'package:prayer/features/common/widgets/chips/text_chip.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/corporate_prayer/providers/corporate_prayer_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CorporatePrayerCard extends ConsumerWidget {
  const CorporatePrayerCard({
    super.key,
    required this.prayerId,
    this.onTap,
  });

  final void Function()? onTap;
  final String prayerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(corporatePrayerProvider(prayerId));

    return Skeletonizer(
      enabled: prayer.isLoading || prayer.hasError || prayer.value == null,
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
                          prayer.value?.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          prayer.value?.description ?? '',
                          style: const TextStyle(
                            color: MyTheme.outline,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  UserProfileImage(
                    size: 40,
                    profile: prayer.value?.user?.profile,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (prayer.value?.startedAt != null)
                    TextChip(
                        icon: FontAwesomeIcons.calendarDays,
                        value:
                            '${Jiffy.parseFromDateTime(prayer.value!.startedAt!.toLocal()).yMMMd}${prayer.value?.endedAt == null ? "" : "-${Jiffy.parseFromDateTime(prayer.value!.endedAt!.toLocal()).yMMMd}"}'),
                  Spacer(),
                  StatisticsChip(
                    icon: FontAwesomeIcons.personPraying,
                    value: prayer.value?.prayersCount ?? 0,
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
