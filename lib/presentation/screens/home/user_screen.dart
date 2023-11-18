import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';
import 'package:prayer/bloc/auth/authentication_event.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/user_model.dart';
import 'package:prayer/presentation/screens/group/groups_screen.dart';
import 'package:prayer/presentation/screens/prayers/prayers_screen.dart';
import 'package:prayer/presentation/widgets/button/follow_button.dart';
import 'package:prayer/presentation/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserScreen extends HookWidget {
  const UserScreen({
    super.key,
    this.uid,
    this.username,
    this.canPop = true,
  });

  final String? uid;
  final String? username;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    final reloadKey = useState(0);
    final fetchUserFn = useMemoized(
        () => context.read<UserRepository>().fetchUser(
              uid: uid ??
                  (username != null
                      ? null
                      : FirebaseAuth.instance.currentUser!.uid),
              username: username,
            ),
        [uid, username, reloadKey.value]);
    final user = useFuture<PUser?>(
      fetchUserFn,
      preserveState: false,
      initialData: PUser.placeholder,
    );
    final prayerPagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final groupPagingController =
        usePagingController<String?, String>(firstPageKey: null);

    return DefaultTabController(
      length: 2,
      child: RefreshIndicator(
        notificationPredicate: (notification) => notification.depth == 2,
        onRefresh: () async {
          if ((uid ?? FirebaseAuth.instance.currentUser!.uid) ==
              FirebaseAuth.instance.currentUser!.uid) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationEvent.refresh());
          }
          prayerPagingController.refresh();
          reloadKey.value = reloadKey.value + 1;
          await Future.wait([fetchUserFn]);
          return;
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
                    expandedHeight: MediaQuery.of(context).size.width,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: [StretchMode.blurBackground],
                      background: UserBannerImage(
                        banner: user.data?.banner,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: Skeletonizer(
                        enabled:
                            user.connectionState == ConnectionState.waiting ||
                                user.data == null,
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
                                    profile: user.data?.profile,
                                    size: 60,
                                  ),
                                ),
                                Spacer(),
                                if (user.data?.uid !=
                                    FirebaseAuth.instance.currentUser?.uid)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: FollowButton(
                                      key: ObjectKey(user.data),
                                      uid: user.data?.uid,
                                      followedAt: user.data?.followedAt,
                                    ),
                                  )
                              ],
                            ),
                            Text(
                              user.data?.name ?? '',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              '@${user.data?.username}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: MyTheme.disabled,
                              ),
                            ),
                            if ((user.data?.bio ?? '') != '') ...[
                              const SizedBox(height: 10),
                              Text(
                                user.data?.bio ?? '',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: MyTheme.onPrimary,
                                ),
                              ),
                            ],
                            const SizedBox(height: 10),
                            ShrinkingButton(
                              onTap: () {
                                if (user.data?.uid != null) {
                                  context
                                      .push('/users/${user.data!.uid}/follows');
                                }
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("${user.data?.followersCount ?? 0}"),
                                      const SizedBox(width: 5),
                                      Text(
                                        "followers",
                                        style:
                                            TextStyle(color: MyTheme.outline),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Text(
                                          "${user.data?.followingsCount ?? 0}"),
                                      const SizedBox(width: 5),
                                      Text(
                                        "followings",
                                        style:
                                            TextStyle(color: MyTheme.outline),
                                      ),
                                    ],
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
                      tabs: ['Prayer', 'Group'],
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    PrayersScreen(
                      key: ObjectKey('prayer.${user.data?.uid}'),
                      physics: const NeverScrollableScrollPhysics(),
                      pagingController: prayerPagingController,
                      fetchFn: user.data?.uid == null || user.data?.uid == ''
                          ? null
                          : (cursor) =>
                              context.read<PrayerRepository>().fetchUserPrayers(
                                    userId: user.data!.uid,
                                    cursor: cursor,
                                  ),
                    ),
                    GroupsScreen(
                      key: ObjectKey('group.${user.data?.uid}'),
                      physics: const NeverScrollableScrollPhysics(),
                      pagingController: groupPagingController,
                      fetchFn: user.data?.uid == ''
                          ? null
                          : (cursor) => context
                              .read<GroupRepository>()
                              .fetchGroupsByUser(
                                  uid: user.data!.uid, cursor: cursor),
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
              if (user.data?.uid == FirebaseAuth.instance.currentUser?.uid)
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
