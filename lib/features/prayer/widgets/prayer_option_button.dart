import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/prayer/models/prayer_model.dart';
import 'package:prayer/features/prayer/providers/deleted_prayer_provider.dart';
import 'package:prayer/features/user/providers/user_provider.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PrayerOptionButton extends ConsumerWidget {
  const PrayerOptionButton({
    super.key,
    required this.prayer,
  });

  final Prayer prayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider(uid: prayer.userId));
    return PullDownButton(
      itemBuilder: (context) => [
        PullDownMenuHeader(
          leading: UserProfileImage(
            profile: prayer.anon == true ? null : prayer.user?.profile,
            imageRadius: BorderRadius.circular(5),
          ),
          title: prayer.anon == true
              ? S.of(context).anonymous
              : '@${prayer.user?.username}',
          icon: FontAwesomeIcons.circleUser,
          onTap: () {
            if (prayer.anon == true) {
              return;
            }
            context.push(
                Uri(path: '/users', queryParameters: {'uid': prayer.user?.uid})
                    .toString());
          },
        ),
        PullDownMenuDivider.large(),
        if (prayer.anon != true &&
            prayer.userId != FirebaseAuth.instance.currentUser?.uid)
          PullDownMenuItem(
            onTap: () => ref
                .read(userNotifierProvider(uid: prayer.userId).notifier)
                .followUser(user.value?.followedAt == null),
            title: user.value?.followedAt == null
                ? S.of(context).followUser('@${user.value?.username}')
                : S.of(context).unfollowUser('@${user.value?.username}'),
            icon: FontAwesomeIcons.lightUserPlus,
          ),
        if (prayer.anon != true &&
            prayer.userId != FirebaseAuth.instance.currentUser?.uid)
          PullDownMenuItem(
            onTap: () => ref
                .read(userNotifierProvider(uid: prayer.userId).notifier)
                .blockUser(user.value?.blockedAt == null),
            title: user.value?.blockedAt == null
                ? S.of(context).blockUser('@${user.value?.username}')
                : S.of(context).unblockUser('@${user.value?.username}'),
            icon: FontAwesomeIcons.lightUserSlash,
            isDestructive: true,
          ),
        if (prayer.userId == FirebaseAuth.instance.currentUser?.uid)
          PullDownMenuItem(
            onTap: () {
              GetIt.I<PrayerRepository>().deletePrayer(prayerId: prayer.id);
              ref.read(deletedPrayerNotifierProvider.notifier).add(prayer.id);
              context.pop('deleted');
            },
            title: S.of(context).delete,
            icon: FontAwesomeIcons.lightTrash,
            isDestructive: true,
          ),
        PullDownMenuItem(
          onTap: () => context.push(
              Uri(path: '/report', queryParameters: {'prayerId': prayer.id})
                  .toString()),
          title: S.of(context).report,
          icon: FontAwesomeIcons.lightFlag,
          isDestructive: true,
        ),
      ],
      buttonBuilder: (context, showMenu) {
        return NavigateIconButton(
          onPressed: showMenu,
          icon: FontAwesomeIcons.ellipsisVertical,
        );
      },
    );
  }
}
