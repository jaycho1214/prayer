import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/presentation/screens/prayers/prayers_screen.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/providers/notification/notification_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePagingController =
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

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      body: RefreshIndicator(
        notificationPredicate: (notification) => notification.depth == 2,
        onRefresh: () async {
          ref.invalidate(notificationNotifierProvider);
          homePagingController.refresh();
        },
        child: CustomScrollView(
          cacheExtent: 5000,
          slivers: [
            SliverAppBar(
              toolbarHeight: 40,
              surfaceTintColor: MyTheme.surface,
              foregroundColor: MyTheme.surface,
              backgroundColor: MyTheme.surface,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
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
                        top: 10,
                        right: 10,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircle,
                          color: Colors.red,
                          size: 8,
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: NavigateIconButton(
                    icon: FontAwesomeIcons.gear,
                    onPressed: () {
                      context.push('/settings');
                    },
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
              title: Text(
                "Prayer",
                style: platformThemeData(
                  context,
                  material: (ThemeData data) => data.textTheme.headlineSmall,
                  cupertino: (data) => data.textTheme.navTitleTextStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              floating: true,
              pinned: false,
              snap: true,
            ),
            PrayersScreen(
              fetchFn: (cursor) =>
                  GetIt.I<PrayerRepository>().fetchHomeFeed(cursor: cursor),
              pagingController: homePagingController,
              sliver: true,
            ),
          ],
        ),
      ),
    );
  }
}
