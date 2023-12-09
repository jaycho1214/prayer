import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/presentation/screens/group/groups_screen.dart';
import 'package:prayer/presentation/screens/prayers/prayers_screen.dart';
import 'package:prayer/presentation/widgets/bibles/bible_card.dart';
import 'package:prayer/presentation/widgets/button/follow_button.dart';
import 'package:prayer/presentation/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/statistics_text.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/providers/user/user_provider.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    final userValue = ref.watch(userProvider(
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

    return DefaultTabController(
      length: 3,
      child: RefreshIndicator(
        notificationPredicate: (notification) => user == PUser.placeholder
            ? notification.depth == 0
            : notification.depth == 2,
        onRefresh: () async {
          prayerPagingController.refresh();
          groupPagingController.refresh();
          prayPagingController.refresh();
          return ref.refresh(userProvider(
            uid: uid,
            username: username,
          ).future);
        },
        child: Container(
          color: MyTheme.surface,
          child: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, _) => [
                  SliverAppBar(
                    surfaceTintColor: MyTheme.surface,
                    foregroundColor: MyTheme.surface,
                    backgroundColor: MyTheme.surface,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    expandedHeight: user?.banner == null
                        ? 100
                        : MediaQuery.of(context).size.width,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: [StretchMode.fadeTitle],
                      background: UserBannerImage(
                        banner: user?.banner,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 0,
                      ),
                      child: Skeletonizer(
                        enabled: userValue.value == null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: MyTheme.surface,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: UserProfileImage(
                                    profile: user?.profile,
                                    size: 60,
                                  ),
                                ),
                                Spacer(),
                                if (user?.uid !=
                                    FirebaseAuth.instance.currentUser?.uid)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: FollowButton(
                                      key: ObjectKey(user),
                                      uid: user?.uid,
                                      followedAt: user?.followedAt,
                                    ),
                                  )
                              ],
                            ),
                            Text(
                              user?.name ?? '',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
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
                            ShrinkingButton(
                              onTap: () {
                                if (user?.uid != null) {
                                  context.push('/users/${user!.uid}/follows');
                                }
                              },
                              child: Row(
                                children: [
                                  StatisticsText(
                                    value: user?.followersCount ?? 0,
                                    text: S.of(context).followers,
                                  ),
                                  const SizedBox(width: 10),
                                  StatisticsText(
                                    value: user?.followingsCount ?? 0,
                                    text: S.of(context).followings,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: TabBarDelegate(
                      tabs: [
                        S.of(context).prayers,
                        S.of(context).groups,
                        S.of(context).prays
                      ],
                    ),
                  ),
                ],
                body: userValue.value == null || (user?.uid ?? '') == ''
                    ? const SizedBox()
                    : TabBarView(
                        children: [
                          PrayersScreen(
                            physics: const NeverScrollableScrollPhysics(),
                            pagingController: prayerPagingController,
                            fetchFn: (cursor) =>
                                GetIt.I<PrayerRepository>().fetchUserPrayers(
                              userId: user!.uid,
                              cursor: cursor,
                            ),
                          ),
                          GroupsScreen(
                            physics: const NeverScrollableScrollPhysics(),
                            pagingController: groupPagingController,
                            fetchFn: (cursor) =>
                                GetIt.I<GroupRepository>().fetchGroupsByUser(
                              uid: user!.uid,
                              cursor: cursor,
                            ),
                          ),
                          PrayersScreen(
                            physics: const NeverScrollableScrollPhysics(),
                            pagingController: prayPagingController,
                            fetchFn: (cursor) => GetIt.I<PrayerRepository>()
                                .fetchPrayerPrayedByUser(
                              userId: user!.uid,
                              cursor: cursor,
                            ),
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
