import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/widgets/image_list.dart';
import 'package:prayer/features/common/widgets/parseable_text.dart';
import 'package:prayer/features/prayer/models/prayer_model.dart';
import 'package:prayer/features/prayer/widgets/labels/corporate_label.dart';
import 'package:prayer/features/prayer/widgets/labels/group_label.dart';
import 'package:prayer/features/prayer/widgets/labels/pinned_label.dart';
import 'package:prayer/features/prayer/widgets/labels/written_by_me.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/bible/widgets/bible_card_list.dart';
import 'package:prayer/features/pray/widgets/pray_chip.dart';
import 'package:prayer/features/user/widgets/user_chip.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerCard extends ConsumerWidget {
  const PrayerCard({
    super.key,
    required this.prayerId,
  });

  final String prayerId;

  Widget _buidlFooterLatestPray(BuildContext context, {Prayer? prayer}) {
    if (prayer?.pray == null) {
      return const SizedBox();
    }
    return Row(
      children: [
        UserProfileImage(
          uid: prayer!.pray!.uid,
          clickActionType: UserProfileImageClickActionType.profile,
          profile: prayer.pray!.profile,
          size: 30,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            t.prayer.someoneHasPrayed(
              username: TextSpan(
                text: prayer.pray!.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 10),
        if (prayer.pray?.createdAt != null)
          Text(
            Formatter.fromNow(prayer.pray!.createdAt!),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerNotifierProvider(prayerId));

    return Skeletonizer(
      enabled: prayer.isLoading || prayer.value == null,
      child: ShrinkingButton(
        onTap: () => context.push('/prayers/$prayerId'),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prayer.value?.pinnedBy != null)
                Padding(
                  padding: const EdgeInsets.only(left: 40, bottom: 5),
                  child: PinnedLabel(pinnedBy: prayer.value!.pinnedBy!),
                ),
              if (prayer.value?.group != null)
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(
                    children: [
                      GroupLabel(prayer: prayer.value!),
                      if (prayer.value?.corporate != null)
                        CorporateLabel(prayer: prayer.value!),
                    ],
                  ),
                ),
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
                  if (prayer.value?.group?.moderator != null &&
                      prayer.value?.anon == false)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        prayer.value?.userId == prayer.value?.group?.adminId
                            ? t.general.admin
                            : t.general.moderator,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (prayer.value?.anon == true &&
                      prayer.value?.userId ==
                          FirebaseAuth.instance.currentUser?.uid)
                    WrittenByMeLabel(),
                  Spacer(),
                  const SizedBox(width: 10),
                  Text(
                    prayer.value?.createdAt == null
                        ? ''
                        : Formatter.fromNow(prayer.value!.createdAt!),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: ParseableText(
                  prayer.value?.value ?? '',
                  trimCollapsedText: t.general.readmore,
                  trimLines: 5,
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
                    child: _buidlFooterLatestPray(
                      context,
                      prayer: prayer.value,
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
