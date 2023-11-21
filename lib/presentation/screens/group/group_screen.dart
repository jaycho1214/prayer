import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/presentation/screens/prayers/group_corporate_prayers_screen.dart';
import 'package:prayer/presentation/screens/prayers/prayers_screen.dart';
import 'package:prayer/presentation/widgets/button/fab.dart';
import 'package:prayer/presentation/widgets/button/join_button.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/providers/group/group_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GroupScreen extends HookConsumerWidget {
  const GroupScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerPagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final corporatePagingController =
        usePagingController<String?, String>(firstPageKey: null);

    ref.listen(GroupNotifierProvider(groupId), (previous, next) {
      next.when(
        data: (value) {},
        error: (err, _) {
          GlobalSnackBar.show(context, message: err.toString());
        },
        loading: () {},
      );
    });

    final data = ref.watch(GroupNotifierProvider(groupId));
    final group = data.value ?? Group.placeholder;

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        backgroundColor: MyTheme.surface,
        title: Text("Group"),
        leading: NavigateBackButton(),
        trailingActions: [
          Center(
            child: PullDownButton(
                itemBuilder: (context) => [
                      PullDownMenuItem(
                        onTap: () {
                          context.push('/groups/$groupId/members');
                        },
                        title: "Members",
                        icon: FontAwesomeIcons.lightUsers,
                      ),
                      PullDownMenuItem(
                        onTap: () => context.push('/form/group', extra: group),
                        title: "Edit",
                        icon: FontAwesomeIcons.penToSquare,
                        enabled: group.adminId ==
                            FirebaseAuth.instance.currentUser?.uid,
                        isDestructive: true,
                      ),
                    ],
                buttonBuilder: (context, showMenu) {
                  return NavigateIconButton(
                    onPressed: showMenu,
                    icon: FontAwesomeIcons.solidEllipsisVertical,
                  );
                }),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              notificationPredicate: (notification) =>
                  group.membershipType == 'private' && group.acceptedAt == null
                      ? notification.depth == 0
                      : notification.depth == 2,
              onRefresh: () async {
                if (DefaultTabController.of(context).index == 0) {
                  prayerPagingController.refresh();
                }
                if (DefaultTabController.of(context).index == 1) {
                  corporatePagingController.refresh();
                }
                return ref.refresh(GroupNotifierProvider(groupId).future);
              },
              child: Stack(
                children: [
                  NestedScrollView(
                    headerSliverBuilder: (context, _) => [
                      SliverToBoxAdapter(
                        child: Skeletonizer(
                          enabled: data.value == null,
                          child: Column(
                            children: [
                              Hero(
                                tag: 'group.$groupId.banner',
                                child: GroupBannerImage(
                                  banner: group.banner,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      group.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    if (group.description != null)
                                      Text(
                                        group.description!,
                                        style: TextStyle(
                                            color: MyTheme.outline,
                                            fontSize: 12),
                                      ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('${group.membersCount} members'),
                                        const SizedBox(width: 15),
                                        Text('${group.prayersCount} prayers'),
                                        Spacer(),
                                        JoinButton(
                                          groupId: groupId,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: TabBarDelegate(
                          tabs: ['Prayer', 'Corporate'],
                        ),
                      ),
                    ],
                    body: group.membershipType == 'private' &&
                            group.acceptedAt == null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            child: Text(
                              "This group is private.\nJoin to see the prayers",
                              textAlign: TextAlign.center,
                            ),
                          )
                        : TabBarView(
                            children: [
                              PrayersScreen(
                                physics: const NeverScrollableScrollPhysics(),
                                fetchFn: (cursor) => GetIt.I<PrayerRepository>()
                                    .fetchGroupPrayers(groupId: groupId),
                                pagingController: prayerPagingController,
                              ),
                              GroupCorporatePrayersScreen(
                                physics: const NeverScrollableScrollPhysics(),
                                groupId: groupId,
                                pagingController: corporatePagingController,
                              ),
                            ],
                          ),
                  ),
                  FAB(
                    onTap: () async {
                      if (DefaultTabController.of(context).index == 0) {
                        final didAdd = await context.push(Uri(
                            path: '/form/prayer',
                            queryParameters: {'groupId': groupId}).toString());
                        if (didAdd == true) {
                          prayerPagingController.refresh();
                        }
                      } else if (DefaultTabController.of(context).index == 1) {
                        if (group.moderator == null) {
                          GlobalSnackBar.show(context,
                              message:
                                  "Only moderators are allowed to post corporate prayers.");
                        } else {
                          final didSomething = await context.push(Uri(
                                  path: '/form/corporate',
                                  queryParameters: {'groupId': groupId})
                              .toString());
                          if (didSomething == true) {
                            corporatePagingController.refresh();
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
