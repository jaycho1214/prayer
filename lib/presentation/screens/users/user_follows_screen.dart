import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/user_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/presentation/widgets/user/user_card.dart';
import 'package:prayer/repo/response_types.dart';
import 'package:prayer/repo/user_repository.dart';

class UsersFollowScreen extends HookWidget {
  const UsersFollowScreen({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    final followersPageController =
        usePagingController<String?, PUser>(firstPageKey: null);
    final followingsPageController =
        usePagingController<String?, PUser>(firstPageKey: null);

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return PlatformScaffold(
            backgroundColor: MyTheme.surface,
            body: RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 2,
              onRefresh: () async {
                switch (DefaultTabController.of(context).index) {
                  case 0:
                    followersPageController.refresh();
                    break;
                  case 1:
                    followingsPageController.refresh();
                    break;
                }
                return null;
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                  SliverAppBar(
                    surfaceTintColor: MyTheme.surface,
                    pinned: true,
                    backgroundColor: MyTheme.surface,
                    leading: NavigateBackButton(),
                  ),
                  SliverPersistentHeader(
                      delegate:
                          TabBarDelegate(tabs: ['Followers', 'Followings'])),
                ],
                body: TabBarView(
                  children: [
                    FollowsPage(
                      pagingController: followersPageController,
                      fetchFn: (cursor) =>
                          GetIt.I<UserRepository>().fetchFollowers(
                        uid,
                        cursor: cursor,
                        type: FollowersType.followers,
                      ),
                    ),
                    FollowsPage(
                      pagingController: followingsPageController,
                      fetchFn: (cursor) =>
                          GetIt.I<UserRepository>().fetchFollowers(
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
        },
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
      final data = await fetchFn(cursor);
      if (data.error != null) {
        talker
            .error('Error while fetching members of the group: ${data.error}');
        pagingController.error = data.error;
      } else if (data.cursor != null) {
        pagingController.appendPage(data.items!, data.cursor);
      } else {
        pagingController.appendLastPage(data.items!);
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
