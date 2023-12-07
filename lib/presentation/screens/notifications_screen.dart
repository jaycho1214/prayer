import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/model/notification/notification_model.dart';
import 'package:prayer/presentation/screens/group/groups_screen.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/notification_card.dart';
import 'package:prayer/presentation/widgets/tab_bar.dart';
import 'package:prayer/providers/notification/notification_provider.dart';
import 'package:prayer/repo/group_repository.dart';

class NotificationsScreen extends HookConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsPagingController =
        usePagingController<int?, CustomNotification>(firstPageKey: null);
    final invitationPagingController =
        usePagingController<int?, Group>(firstPageKey: null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(notificationNotifierProvider.notifier).readNow();
      });
      return () => null;
    }, []);

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return PlatformScaffold(
            backgroundColor: MyTheme.surface,
            body: RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 2,
              onRefresh: () async {
                if (DefaultTabController.of(context).index == 0) {
                  notificationsPagingController.refresh();
                } else {
                  invitationPagingController.refresh();
                }
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    toolbarHeight: 40,
                    surfaceTintColor: MyTheme.surface,
                    foregroundColor: MyTheme.surface,
                    backgroundColor: MyTheme.surface,
                    automaticallyImplyLeading: false,
                    title: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            S.of(context).notifications,
                            textAlign: TextAlign.center,
                            style: platformThemeData(
                              context,
                              material: (ThemeData data) => data
                                  .textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              cupertino: (data) => data
                                  .textTheme.navTitleTextStyle
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -13,
                          left: 0,
                          child: NavigateBackButton(),
                        ),
                      ],
                    ),
                    floating: true,
                    pinned: true,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(48),
                      child: CustomTabBar(
                        tabs: [
                          S.of(context).notifications,
                          S.of(context).invitation
                        ],
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    NotificationsListScreen(
                      pagingController: notificationsPagingController,
                    ),
                    GroupsScreen(
                      fetchFn: (cursor) => GetIt.I<GroupRepository>()
                          .fetchInvitedGroups(cursor: cursor),
                      pagingController: invitationPagingController,
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

class NotificationsListScreen extends HookWidget {
  const NotificationsListScreen({
    super.key,
    required this.pagingController,
  });

  final PagingController<int?, CustomNotification> pagingController;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final requestPage = useCallback((int? cursor) {
      dio.get('/v1/notifications', queryParameters: {'cursor': cursor}).then(
          (data) {
        final notifications =
            List<Map<String, Object?>>.from(data.data['data'] ?? [])
                .map((e) => CustomNotification.fromJson(e))
                .toList();
        final newCursor = data.data['cursor'];
        if (newCursor == null) {
          pagingController.appendLastPage(notifications);
        } else {
          pagingController.appendPage(notifications, newCursor);
        }
      }).catchError((e) {
        talker.error("Error on fetching next page of notifications: $e");
        pagingController.error = e;
      });
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () {
        pagingController.removePageRequestListener(requestPage);
      };
    }, []);

    return PagedListView<int?, CustomNotification>(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, item, index) => NotificationCard(
          item: item,
        ),
      ),
    );
  }
}
