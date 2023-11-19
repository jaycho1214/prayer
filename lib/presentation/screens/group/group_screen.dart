import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/bloc/group/group_bloc.dart';
import 'package:prayer/bloc/group/group_event.dart';
import 'package:prayer/bloc/group/group_state.dart';
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
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GroupScreen extends HookWidget {
  const GroupScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context) {
    final prayerPagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final corporatePagingController =
        usePagingController<String?, String>(firstPageKey: null);

    final bloc = useMemoized(
        () => GroupBloc(
              groupId: groupId,
              groupRepository: context.read<GroupRepository>(),
            ),
        []);

    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<GroupBloc, GroupState>(
        listener: (context, state) => switch (state) {
          GroupStateError(message: final message) =>
            GlobalSnackBar.show(context, message: message),
          GroupStateLoaded(group: _, message: final message) => message != null
              ? GlobalSnackBar.show(context, message: message)
              : null,
          _ => null,
        },
        child: PlatformScaffold(
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
                              context.push(
                                '/groups/$groupId/members',
                                extra: bloc,
                              );
                            },
                            title: "Members",
                            icon: FontAwesomeIcons.lightUsers,
                          ),
                          PullDownMenuItem(
                            onTap: () async {
                              final didEdit = await context.push(
                                '/form/group',
                                extra: (bloc.state as GroupStateLoaded).group,
                              );
                              if (didEdit == true) {
                                bloc.add(GroupEvent.load());
                              }
                            },
                            title: "Edit",
                            icon: FontAwesomeIcons.penToSquare,
                            enabled: (bloc.state as GroupStateLoaded)
                                    .group
                                    .adminId ==
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
          body: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              final data = switch (state) {
                GroupStateLoaded(group: final group) => group,
                GroupStateRefreshing(group: final group) => group,
                _ => Group.placeholder,
              };
              return DefaultTabController(
                length: 2,
                child: Builder(
                  builder: (context) {
                    return RefreshIndicator(
                      notificationPredicate: (notification) =>
                          notification.depth == 2,
                      onRefresh: () async {
                        final future = context
                            .read<GroupBloc>()
                            .stream
                            .firstWhere((state) =>
                                state is GroupStateLoaded ||
                                state is GroupStateError);
                        context.read<GroupBloc>().add(GroupEvent.load());
                        if (DefaultTabController.of(context).index == 0) {
                          prayerPagingController.refresh();
                        }
                        if (DefaultTabController.of(context).index == 1) {
                          corporatePagingController.refresh();
                        }
                        await future;
                      },
                      child: Stack(
                        children: [
                          NestedScrollView(
                            headerSliverBuilder: (context, _) => [
                              SliverToBoxAdapter(
                                child: Skeletonizer(
                                  enabled: state is GroupStateIdle ||
                                      state is GroupStateError,
                                  child: Column(
                                    children: [
                                      Hero(
                                        tag: 'group.$groupId.banner',
                                        child: GroupBannerImage(
                                          banner: data.banner,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            Text(
                                              data.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            if (data.description != null)
                                              Text(
                                                data.description!,
                                                style: TextStyle(
                                                    color: MyTheme.outline,
                                                    fontSize: 12),
                                              ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    '${data.membersCount} members'),
                                                const SizedBox(width: 15),
                                                Text(
                                                    '${data.prayersCount} prayers'),
                                                Spacer(),
                                                JoinButton(),
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
                            body: data.membershipType == 'private' &&
                                    data.acceptedAt == null
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        fetchFn: (cursor) => context
                                            .read<PrayerRepository>()
                                            .fetchGroupPrayers(
                                                groupId: groupId),
                                        pagingController:
                                            prayerPagingController,
                                      ),
                                      GroupCorporatePrayersScreen(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        groupId: groupId,
                                        pagingController:
                                            corporatePagingController,
                                      ),
                                    ],
                                  ),
                          ),
                          FAB(
                            onTap: () async {
                              if (DefaultTabController.of(context).index == 0) {
                                final didAdd = await context.push(Uri(
                                        path: '/form/prayer',
                                        queryParameters: {'groupId': groupId})
                                    .toString());
                                if (didAdd == true) {
                                  prayerPagingController.refresh();
                                }
                              } else if (DefaultTabController.of(context)
                                      .index ==
                                  1) {
                                if (data.moderator == null) {
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
              );
            },
          ),
        ),
      ),
    );
  }
}
