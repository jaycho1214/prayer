import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group_member_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/form/sheet/member_picker.dart';
import 'package:prayer/presentation/widgets/form/sheet/invite_users_picker.dart';
import 'package:prayer/presentation/widgets/tab_bar.dart';
import 'package:prayer/presentation/widgets/user/group_member_card.dart';
import 'package:prayer/providers/group/group_provider.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/response_types.dart';
import 'package:pull_down_button/pull_down_button.dart';

class GroupMembersScreen extends HookConsumerWidget {
  const GroupMembersScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(GroupNotifierProvider(groupId)).value;
    final membersPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final moderatorsPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final requestsPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final invitesPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);

    return DefaultTabController(
      length:
          group?.moderator != null && group?.membershipType != 'open' ? 4 : 2,
      child: Builder(
        builder: (context) {
          return PlatformScaffold(
            backgroundColor: MyTheme.surface,
            body: RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 2,
              onRefresh: () async {
                switch (DefaultTabController.of(context).index) {
                  case 0:
                    moderatorsPageController.refresh();
                    break;
                  case 1:
                    membersPageController.refresh();
                    break;
                  case 2:
                    requestsPageController.refresh();
                    break;
                  case 3:
                    invitesPageController.refresh();
                    break;
                }
                return null;
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      toolbarHeight: 40,
                      pinned: true,
                      surfaceTintColor: MyTheme.surface,
                      backgroundColor: MyTheme.surface,
                      title: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Members',
                                style: platformThemeData(
                                  context,
                                  material: (ThemeData data) =>
                                      data.textTheme.headlineSmall,
                                  cupertino: (data) =>
                                      data.textTheme.navTitleTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -13,
                            left: 0,
                            child: NavigateBackButton(),
                          ),
                          if (group?.moderator != null)
                            Positioned(
                              top: -13,
                              right: 0,
                              child: InviteUsersPicker(
                                  groupId: groupId,
                                  builder: (context, showUsersPicker) {
                                    return MemberPicker(
                                      groupId: groupId,
                                      builder: (context, showPromotePicker) {
                                        return PullDownButton(
                                          itemBuilder: (context) => [
                                            PullDownMenuItem(
                                              onTap: () async {
                                                if (await showUsersPicker() ==
                                                    true) {
                                                  invitesPageController
                                                      .refresh();
                                                }
                                              },
                                              title: 'Invite',
                                              icon: FontAwesomeIcons.envelope,
                                            ),
                                            if (group?.adminId ==
                                                FirebaseAuth
                                                    .instance.currentUser?.uid)
                                              PullDownMenuItem(
                                                onTap: () async {
                                                  if (await showPromotePicker() !=
                                                      null) {
                                                    moderatorsPageController
                                                        .refresh();
                                                    membersPageController
                                                        .refresh();
                                                  }
                                                },
                                                title: 'Promote',
                                                icon:
                                                    FontAwesomeIcons.userShield,
                                              ),
                                          ],
                                          buttonBuilder: (context, showMenu) =>
                                              NavigateIconButton(
                                            icon: FontAwesomeIcons
                                                .ellipsisVertical,
                                            onPressed: showMenu,
                                          ),
                                        );
                                      },
                                    );
                                  }),
                            ),
                        ],
                      ),
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(60),
                        child: CustomTabBar(
                          tabs: [
                            'Moderators',
                            'Members',
                            if (group?.moderator != null &&
                                group?.membershipType != 'open')
                              'Requests',
                            if (group?.moderator != null &&
                                group?.membershipType != 'open')
                              'Invites'
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: ['moderators', 'members', 'requests', 'invites']
                      .map(
                        (e) => Builder(
                          builder: (context) => CustomScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverOverlapInjector(
                                  handle: NestedScrollView
                                      .sliverOverlapAbsorberHandleFor(context)),
                              MembersPage(
                                fetchFn: (cursor) => switch (e) {
                                  'invites' => GetIt.I<GroupRepository>()
                                        .fetchGroupInvites(
                                      groupId: groupId,
                                      cursor: cursor,
                                    ),
                                  _ => GetIt.I<GroupRepository>()
                                        .fetchGroupMembers(
                                      groupId: groupId,
                                      cursor: cursor,
                                      type: e,
                                    ),
                                },
                                pagingController: switch (e) {
                                  'moderators' => moderatorsPageController,
                                  'members' => membersPageController,
                                  'requests' => requestsPageController,
                                  _ => invitesPageController,
                                },
                                onAction: (actionType, _) {
                                  if (actionType ==
                                      GroupMemberCardActionType.accept) {
                                    membersPageController.refresh();
                                    requestsPageController.refresh();
                                  } else {
                                    invitesPageController.refresh();
                                  }
                                },
                                groupId: groupId,
                                membersType: e,
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MembersPage extends HookWidget {
  const MembersPage({
    super.key,
    required this.fetchFn,
    required this.groupId,
    required this.membersType,
    required this.pagingController,
    this.onAction,
  });

  final Future<PaginationResponse<GroupMember, String?>> Function(dynamic)
      fetchFn;
  final PagingController<String?, GroupMember> pagingController;
  final String groupId;
  final String membersType;
  final void Function(GroupMemberCardActionType, String)? onAction;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final fetchPage = useCallback((String? cursor) async {
      try {
        PaginationResponse<GroupMember, dynamic> data;
        if (membersType == 'invites') {
          data = await GetIt.I<GroupRepository>().fetchGroupInvites(
            groupId: groupId,
            cursor: cursor,
          );
        } else {
          data = await GetIt.I<GroupRepository>().fetchGroupMembers(
            groupId: groupId,
            cursor: cursor,
            type: membersType,
          );
        }
        if (data.cursor != null) {
          pagingController.appendPage(data.items ?? [], data.cursor);
        } else {
          pagingController.appendLastPage(data.items ?? []);
        }
      } catch (error) {
        talker.error('Error while fetching members of the group: $error');
        pagingController.error = error;
      }
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(fetchPage);

      return () => pagingController.removePageRequestListener(fetchPage);
    }, [fetchPage]);

    return PagedSliverList(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<GroupMember>(
        itemBuilder: (context, item, index) => GroupMemberCard(
          onDone: (actionType) => onAction?.call(actionType, item.uid),
          groupId: groupId,
          member: item,
          showAccept: membersType == 'requests',
          showUndoInvite: membersType == 'invites',
        ),
      ),
    );
  }
}
