import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/statistics_text.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/features/group/widgets/groups_screen.dart';
import 'package:prayer/features/prayer/widgets/prayers_screen.dart';
import 'package:prayer/features/bible/widgets/bible_card.dart';
import 'package:prayer/features/user/widgets/follow_button.dart';
import 'package:prayer/features/common/sheets/confirm_menu_form.dart';
import 'package:prayer/features/common/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/features/common/widgets/notification_bar.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/user/providers/user_provider.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/utils/utils.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SliverUserAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverUserAppBarDelegate({
    this.minHeight = 110,
    required this.maxHeight,
    required this.offset,
    this.user,
  });

  final double minHeight;
  final double maxHeight;
  final double offset;
  final PUser? user;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight + 60;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxHeight + 60,
      child: Stack(
        children: [
          if (user?.uid != FirebaseAuth.instance.currentUser?.uid)
            Positioned(
              right: 20,
              bottom: 10,
              child: Transform.translate(
                offset: Offset(0, -offset),
                child: Container(
                  child: FollowButton(
                    key: ObjectKey(user),
                    uid: user?.uid,
                    followedAt: user?.followedAt,
                  ),
                ),
              ),
            ),
          Transform.scale(
            scale: Utils.interpolate(offset, [-200, 0, 300], [2, 1, 1]),
            child: Container(
              height: maxHeight,
              width: MediaQuery.of(context).size.width,
              child: user?.banner == null
                  ? UserBannerImage(banner: user?.banner)
                  : ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: Utils.interpolate(
                            offset, [-200, 0, 360, 380], [5, 0, 0, 5]),
                        sigmaY: Utils.interpolate(
                            offset, [-200, 0, 360, 380], [5, 0, 0, 5]),
                      ),
                      child: UserBannerImage(
                        banner: user?.banner,
                      ),
                    ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: Utils.interpolate(shrinkOffset, [0, 60], [10, -15]),
            child: Transform.translate(
              offset: Offset(
                  0, Utils.interpolate(offset, [-200, 0, 300], [220, 0, 0])),
              child: Opacity(
                opacity: Utils.interpolate(shrinkOffset, [0, 60], [1.0, 0.0]),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyTheme.surface,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: UserProfileImage(
                    profile: user?.profile,
                    size: Utils.interpolate(shrinkOffset, [0, 50], [80, 40]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverUserAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        offset != oldDelegate.offset ||
        user != oldDelegate.user;
  }

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();
}

class UserScreen extends HookConsumerWidget {
  const UserScreen({
    super.key,
    this.uid,
    this.username,
    this.canPop = true,
  }) : assert(uid == null || username == null);

  final String? uid;
  final String? username;
  final bool canPop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userValue = ref.watch(userNotifierProvider(
      uid: uid ??
          (username != null ? null : FirebaseAuth.instance.currentUser!.uid),
      username: username,
    ));
    final user = userValue.when(
      data: (value) => value,
      error: (_, __) => PUser.placeholder,
      loading: () => PUser.placeholder,
    );
    final prayerPagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final prayPagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final groupPagingController =
        usePagingController<String?, Group>(firstPageKey: null);

    final offset = useState(0.0);
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {
        offset.value = scrollController.offset;
      });
      return () => null;
    }, []);

    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            notificationPredicate: (notification) => user == PUser.placeholder
                ? notification.depth == 0
                : notification.depth == 0,
            onRefresh: () async {
              final index = DefaultTabController.of(context).index;
              final state = ref.refresh(userNotifierProvider(
                uid: uid,
                username: username,
              ).future);
              await state;
              switch (index) {
                case 0:
                  prayerPagingController.refresh();
                  break;
                case 1:
                  groupPagingController.refresh();
                  break;
                case 2:
                  prayPagingController.refresh();
                  break;
              }
            },
            child: Container(
              color: MyTheme.surface,
              child: Stack(
                children: [
                  NestedScrollViewPlus(
                    controller: scrollController,
                    headerSliverBuilder: (context, _) => [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverUserAppBarDelegate(
                          maxHeight: user?.banner == null
                              ? 200
                              : MediaQuery.of(context).size.width,
                          user: user,
                          offset: offset.value,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Skeletonizer(
                            enabled: userValue.value == null,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.name ?? '',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  '@${user?.username}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: MyTheme.disabled,
                                  ),
                                ),
                                if ((user?.bio ?? '') != '') ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    user?.bio ?? '',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: MyTheme.onPrimary,
                                    ),
                                  ),
                                ],
                                if (user?.verseId != null)
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: BibleCard(verseId: user!.verseId!),
                                  ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    StatisticsText(
                                      value: user?.praysCount ?? 0,
                                      text: S.of(context).prays,
                                    ),
                                    const SizedBox(width: 10),
                                    StatisticsText(
                                      value: user?.prayersCount ?? 0,
                                      text: S.of(context).prayers,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    ShrinkingButton(
                                      onTap: () {
                                        if (user?.uid != null) {
                                          context.push(
                                              '/users/${user!.uid}/followers');
                                        }
                                      },
                                      child: StatisticsText(
                                        value: user?.followersCount ?? 0,
                                        text: S.of(context).followers,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ShrinkingButton(
                                      onTap: () {
                                        if (user?.uid != null) {
                                          context.push(Uri(
                                              path:
                                                  '/users/${user!.uid}/followings',
                                              queryParameters: {
                                                'showFollowings': 'true'
                                              }).toString());
                                        }
                                      },
                                      child: StatisticsText(
                                        value: user?.followingsCount ?? 0,
                                        text: S.of(context).followings,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                      OverlapAbsorberPlus(
                        sliver: SliverPersistentHeader(
                          pinned: true,
                          delegate: TabBarDelegate(
                            tabs: [
                              S.of(context).prayers,
                              S.of(context).groups,
                              S.of(context).prays
                            ],
                          ),
                        ),
                      ),
                    ],
                    body: userValue.value == null || (user?.uid ?? '') == ''
                        ? const SizedBox()
                        : TabBarView(
                            children: [
                              Builder(
                                builder: (context) {
                                  return CustomScrollView(
                                    physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics(),
                                    ),
                                    slivers: [
                                      OverlapInjectorPlus(),
                                      PrayersScreen(
                                        sliver: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        pagingController:
                                            prayerPagingController,
                                        fetchFn: (cursor) =>
                                            GetIt.I<PrayerRepository>()
                                                .fetchUserPrayers(
                                          userId: user!.uid,
                                          cursor: cursor,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Builder(builder: (context) {
                                return CustomScrollView(
                                  slivers: [
                                    GroupsScreen(
                                      sliver: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      pagingController: groupPagingController,
                                      fetchFn: (cursor) =>
                                          GetIt.I<GroupRepository>()
                                              .fetchGroupsByUser(
                                        uid: user!.uid,
                                        cursor: cursor,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              Builder(builder: (context) {
                                return CustomScrollView(
                                  slivers: [
                                    PrayersScreen(
                                      sliver: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      pagingController: prayPagingController,
                                      fetchFn: (cursor) =>
                                          GetIt.I<PrayerRepository>()
                                              .fetchPrayerPrayedByUser(
                                        userId: user!.uid,
                                        cursor: cursor,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                  ),
                  if (canPop)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 20,
                      child: ShrinkingButton(
                        onTap: () => context.pop(),
                        child: Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.solidChevronLeft,
                            color: MyTheme.onPrimary,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  if (user?.uid == FirebaseAuth.instance.currentUser?.uid)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      right: 20,
                      child: ShrinkingButton(
                        onTap: () => context.push('/form/user'),
                        child: Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.pencil,
                            color: MyTheme.onPrimary,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  if (user?.uid != FirebaseAuth.instance.currentUser?.uid)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 10,
                      right: 20,
                      child: PullDownButton(
                        itemBuilder: (context) => [
                          PullDownMenuItem(
                            onTap: () {
                              if (user?.uid == null) {
                                return;
                              }
                              ref
                                  .read(userNotifierProvider(uid: user!.uid)
                                      .notifier)
                                  .followUser(user.followedAt == null);
                            },
                            title: user?.followedAt == null
                                ? S.of(context).followUser('@${user?.username}')
                                : S
                                    .of(context)
                                    .unfollowUser('@${user?.username}'),
                            icon: FontAwesomeIcons.userPlus,
                          ),
                          PullDownMenuItem(
                            onTap: () async {
                              if (user?.uid == null) {
                                return;
                              }
                              final resp = await ConfirmMenuForm.show(
                                context,
                                title: S
                                    .of(context)
                                    .blockUser('@${user?.username}'),
                                icon: FontAwesomeIcons.userSlash,
                                description: S
                                    .of(context)
                                    .blockUserDescription
                                    .split(':'),
                              );
                              if (resp == true) {
                                try {
                                  ref
                                      .read(userNotifierProvider(uid: user!.uid)
                                          .notifier)
                                      .blockUser(user.blockedAt == null);
                                  NotificationSnackBar.show(context,
                                      message: S.of(context).blocked);
                                } catch (e, st) {
                                  talker.handle(e, st,
                                      '[UserScreen] Failed to block a user');
                                  GlobalSnackBar.show(context,
                                      message: "Failed to block a user");
                                }
                              }
                            },
                            title: user?.blockedAt == null
                                ? S.of(context).blockUser('@${user?.username}')
                                : S
                                    .of(context)
                                    .unblockUser('@${user?.username}'),
                            icon: FontAwesomeIcons.userSlash,
                            isDestructive: true,
                          ),
                          PullDownMenuItem(
                            onTap: () {
                              context.push(Uri(
                                      path: '/report',
                                      queryParameters: {'userId': user?.uid})
                                  .toString());
                            },
                            title: S.of(context).report,
                            icon: FontAwesomeIcons.flag,
                            isDestructive: true,
                          ),
                        ],
                        buttonBuilder: (context, showMenu) {
                          return ShrinkingButton(
                            onTap: showMenu,
                            child: Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.ellipsis,
                                color: MyTheme.onPrimary,
                                size: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
