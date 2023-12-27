import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/image_list.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/bible/widgets/bible_card_list.dart';
import 'package:prayer/features/pray/widgets/pray_chip.dart';
import 'package:prayer/features/user/widgets/user_chip.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:readmore/readmore.dart';
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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prayer.value?.group != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      ShrinkingButton(
                        onTap: () =>
                            context.push('/groups/${prayer.value?.groupId}'),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            FaIcon(
                              FontAwesomeIcons.userGroupSimple,
                              size: 13,
                              color: MyTheme.placeholderText,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              prayer.value?.group?.name ?? '',
                              style: TextStyle(
                                color: MyTheme.placeholderText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: FaIcon(
                                  FontAwesomeIcons.solidChevronRight,
                                  size: 10,
                                  color: MyTheme.placeholderText,
                                ),
                              ),
                              Text(
                                prayer.value?.corporate?.title ?? '',
                                style: TextStyle(
                                  color: MyTheme.placeholderText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
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
                    username: prayer.value?.user?.username,
                  ),
                  Spacer(),
                  const SizedBox(width: 10),
                  Text(
                    prayer.value?.createdAt == null
                        ? ''
                        : Formatter.fromNow(prayer.value!.createdAt!),
                    style: TextStyle(color: MyTheme.outline),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AbsorbPointer(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: ReadMoreText(
                    prayer.value?.value ?? '',
                    trimCollapsedText: S.of(context).readmore,
                    trimLines: 5,
                    moreStyle: TextStyle(
                      color: MyTheme.placeholderText,
                    ),
                    trimMode: TrimMode.Line,
                  ),
                ),
              ),
              if (prayer.value?.verses != null &&
                  prayer.value!.verses.length > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                  child: BibleCardList(
                    verses: prayer.value?.verses ?? [],
                  ),
                ),
              if (prayer.value?.contents != null &&
                  prayer.value!.contents.length > 0)
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                  child: ImageList(
                      images:
                          prayer.value!.contents.map((e) => e.path).toList()),
                ),
              const SizedBox(height: 10),
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
                                  S.of(context).someoneHasPrayed(
                                      prayer.value!.pray!.username),
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
