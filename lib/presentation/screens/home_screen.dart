import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/placeholder.dart';
import 'package:prayer/presentation/screens/prayers/prayers_screen.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  Future<Map> fetchRandomBible() async {
    final resp =
        await dio.get('https://bible-api.com/?random=verse&translation=kjv');
    return {
      'verse': resp.data['text'],
      'reference': resp.data['reference'],
    };
  }

  @override
  Widget build(BuildContext context) {
    final refreshKey = useState(0);
    final bibleSnapshot = useFuture(
      useMemoized(() => fetchRandomBible(), [refreshKey.value]),
      preserveState: false,
    );
    final homePagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final groupPagingController =
        usePagingController<String?, String>(firstPageKey: null);

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return PlatformScaffold(
            backgroundColor: MyTheme.surface,
            body: RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 2,
              onRefresh: () async {
                refreshKey.value += 1;
                if (DefaultTabController.of(context).index == 0) {
                  homePagingController.refresh();
                } else {
                  groupPagingController.refresh();
                }
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    surfaceTintColor: MyTheme.surface,
                    foregroundColor: MyTheme.surface,
                    backgroundColor: MyTheme.surface,
                    title: Text(
                      "Prayer",
                      style: platformThemeData(
                        context,
                        material: (ThemeData data) =>
                            data.textTheme.headlineSmall,
                        cupertino: (data) => data.textTheme.navTitleTextStyle,
                      ),
                    ),
                    actions: [
                      NavigateIconButton(
                        icon: FontAwesomeIcons.gear,
                        onPressed: () {
                          context.push('/settings');
                        },
                      ),
                    ],
                    floating: true,
                    pinned: true,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(48),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Tab(
                            text: 'Home',
                            height: 20,
                            iconMargin: const EdgeInsets.only(bottom: 0.0),
                          ),
                          Tab(text: 'Group'),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Skeletonizer(
                      enabled: bibleSnapshot.data == null,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              bibleSnapshot.data?['verse'] ?? LoremIpsum,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              bibleSnapshot.data?['reference'] ?? 'REFERENCE',
                              style: TextStyle(color: MyTheme.outline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    PrayersScreen(
                      fetchFn: (cursor) => context
                          .read<PrayerRepository>()
                          .fetchHomeFeed(cursor: cursor),
                      pagingController: homePagingController,
                    ),
                    PrayersScreen(
                      fetchFn: (cursor) => context
                          .read<PrayerRepository>()
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
