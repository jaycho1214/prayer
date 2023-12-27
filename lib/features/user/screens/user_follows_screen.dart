import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/user/providers/user_provider.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/features/user/widgets/user_card.dart';
import 'package:prayer/repo/response_types.dart';
import 'package:prayer/repo/user_repository.dart';

enum UsersFollowScreenPage { followings, followers }

class UsersFollowScreen extends HookConsumerWidget {
  const UsersFollowScreen({
    super.key,
    required this.uid,
    this.initialScreen,
  });

  final String uid;
  final UsersFollowScreenPage? initialScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: 2,
      initialIndex: initialScreen == UsersFollowScreenPage.followings ? 1 : 0,
    );
    final user = ref.watch(userNotifierProvider(uid: uid));
    final followersPageController =
        usePagingController<String?, PUser>(firstPageKey: null);
    final followingsPageController =
        usePagingController<String?, PUser>(firstPageKey: null);

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      body: RefreshIndicator(
        notificationPredicate: (notification) => notification.depth == 2,
        onRefresh: () async {
          switch (tabController.index) {
            case 0:
              return followersPageController.refresh();
            case 1:
              return followingsPageController.refresh();
          }
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              surfaceTintColor: MyTheme.surface,
              pinned: true,
              backgroundColor: MyTheme.surface,
              leading: NavigateBackButton(),
              title: Text(
                user.valueOrNull?.username ?? '',
                style: platformThemeData(
                  context,
                  material: (ThemeData data) => data.textTheme.headlineSmall,
                  cupertino: (data) => data.textTheme.navTitleTextStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: TabBarDelegate(
                controller: tabController,
                tabs: [S.of(context).followers, S.of(context).followings],
              ),
            ),
          ],
          body: TabBarView(
            controller: tabController,
            children: [
              FollowsPage(
                pagingController: followersPageController,
                fetchFn: (cursor) => GetIt.I<UserRepository>().fetchFollowers(
                  uid,
                  cursor: cursor,
                  type: FollowersType.followers,
                ),
              ),
              FollowsPage(
                pagingController: followingsPageController,
                fetchFn: (cursor) => GetIt.I<UserRepository>().fetchFollowers(
                  uid,
                  cursor: cursor,
                  type: FollowersType.followings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowsPage extends HookWidget {
  const FollowsPage({
    super.key,
    required this.fetchFn,
    required this.pagingController,
  });

  final Future<PaginationResponse<PUser, String?>> Function(String?) fetchFn;
  final PagingController<String?, PUser> pagingController;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final fetchPage = useCallback((String? cursor) async {
      try {
        final data = await fetchFn(cursor);
        if (data.cursor != null) {
          pagingController.appendPage(data.items!, data.cursor);
        } else {
          pagingController.appendLastPage(data.items!);
        }
      } catch (e, st) {
        talker.handle(
            e, st, '[FollowsPage] Failed to fetch members of the group');
        pagingController.error = e;
      }
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(fetchPage);

      return () => pagingController.removePageRequestListener(fetchPage);
    }, [fetchPage]);

    return PagedListView<String?, PUser>(
      pagingController: pagingController,
      padding: const EdgeInsets.all(0),
      builderDelegate: PagedChildBuilderDelegate<PUser>(
        itemBuilder: (context, item, index) => UserCard(
          uid: item.uid,
          name: item.name,
          username: item.username,
          profile: item.profile,
        ),
      ),
    );
  }
}
