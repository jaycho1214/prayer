import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/chip/pray_chip.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/providers/prayer/prayer_provider.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerCard extends ConsumerWidget {
  const PrayerCard({
    super.key,
    required this.prayerId,
    this.onTap,
  });

  final void Function()? onTap;
  final String prayerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerNotifierProvider(prayerId));

    return Skeletonizer(
      enabled: prayer.isLoading || prayer.value == null,
      child: ShrinkingButton(
        onTap: () {
          context.push('/prayers/$prayerId');
          onTap?.call();
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prayer.value?.group != null) ...[
                Row(
                  children: [
                    ShrinkingButton(
                      onTap: () {
                        context.push('/groups/${prayer.value?.groupId}');
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          FaIcon(
                            FontAwesomeIcons.lightUsers,
                            size: 13,
                            color: MyTheme.onPrimary,
                          ),
                          const SizedBox(width: 5),
                          Text(prayer.value?.group?.name ?? ''),
                        ],
                      ),
                    ),
                    if (prayer.value?.corporate != null)
                      ShrinkingButton(
                        onTap: () {
                          context.push(
                              '/prayers/corporate/${prayer.value?.corporateId}');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5),
                            FaIcon(
                              FontAwesomeIcons.chevronRight,
                              size: 10,
                              color: MyTheme.onPrimary,
                            ),
                            const SizedBox(width: 5),
                            Text(prayer.value?.corporate?.title ?? ''),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserChip(
                    anon: prayer.value?.anon == true,
                    uid: prayer.value?.userId,
                    profile: prayer.value?.user?.profile,
                    name: prayer.value?.user?.name,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    prayer.value?.createdAt == null
                        ? ''
                        : Formatter.fromNow(prayer.value!.createdAt!),
                    style: TextStyle(color: MyTheme.outline),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                prayer.value?.value ?? '',
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              if (prayer.value?.media != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 80, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: prayer.value!.media!,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: prayer.value?.pray == null
                        ? const SizedBox()
                        : Row(
                            children: [
                              UserProfileImage(
                                profile: prayer.value?.pray?.profile,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '${prayer.value?.pray?.username} has prayed',
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (prayer.value?.pray?.createdAt != null)
                                Text(
                                  Formatter.fromNow(
                                      prayer.value!.pray!.createdAt!),
                                  style: TextStyle(
                                    color: MyTheme.outline,
                                  ),
                                ),
                              const SizedBox(width: 10),
                            ],
                          ),
                  ),
                  PrayChip(prayerId: prayerId),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
