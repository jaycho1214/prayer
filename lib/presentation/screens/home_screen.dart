import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/presentation/screens/prayers/prayers_screen.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/tab_bar.dart';
import 'package:prayer/providers/notification/notification_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final groupPagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final hasNewNotification = ref.watch(notificationNotifierProvider).when(
          data: (v) => v,
          loading: () => false,
          error: (err, __) {
            talker.error(
                "Error while fetching latest notification status", err);
            return false;
          },
        );

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return PlatformScaffold(
            backgroundColor: MyTheme.surface,
            body: RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 2,
              onRefresh: () async {
                ref.invalidate(notificationNotifierProvider);
                if (DefaultTabController.of(context).index == 0) {
                  homePagingController.refresh();
                } else {
                  groupPagingController.refresh();
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
                            "Prayer",
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
                          child: Stack(
                            children: [
                              NavigateIconButton(
                                icon: FontAwesomeIcons.bell,
                                onPressed: () {
                                  context.push('/notifications');
                                },
                              ),
                              if (hasNewNotification)
                                Positioned(
                                  top: 14,
                                  right: 14,
                                  child: FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    color: Colors.red,
                                    size: 8,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -13,
                          right: 0,
                          child: NavigateIconButton(
                            icon: FontAwesomeIcons.gear,
                            onPressed: () {
                              context.push('/settings');
                            },
                          ),
                        ),
                      ],
                    ),
                    floating: true,
                    pinned: true,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(48),
                      child: CustomTabBar(
                        tabs: [S.of(context).home, S.of(context).groups],
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    PrayersScreen(
                      fetchFn: (cursor) => GetIt.I<PrayerRepository>()
                          .fetchHomeFeed(cursor: cursor),
                      pagingController: homePagingController,
                    ),
                    PrayersScreen(
                      fetchFn: (cursor) => GetIt.I<PrayerRepository>()
                          .fetchGroupPrayersFromUser(cursor: cursor),
                      pagingController: groupPagingController,
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
