import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/common/widgets/tab_bar.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/group/models/group_member/group_member_model.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/group/widgets/forms/invite_users_picker.dart';
import 'package:prayer/features/group/widgets/group_member_card.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/response_types.dart';

class GroupMembersScreen extends HookConsumerWidget {
  const GroupMembersScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupNotifierProvider(groupId)).value;
    final membersPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final moderatorsPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final requestsPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final invitesPageController =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final bansPageControler =
        usePagingController<String?, GroupMember>(firstPageKey: null);
    final tabs = useMemoized(() {
      if (group?.moderator != null) {
        if (group?.membershipType == 'open') {
          return ['moderators', 'members', 'bans'];
        }
        return ['moderators', 'members', 'requests', 'invites', 'bans'];
      }
      return ['moderators', 'members'];
    }, [group?.moderator, group?.membershipType]);

    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (context) {
          return PlatformScaffold(
            body: RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 2,
              onRefresh: () async {
                switch (DefaultTabController.of(context).index) {
                  case 0:
                    return moderatorsPageController.refresh();
                  case 1:
                    return membersPageController.refresh();
                  case 2:
                    return requestsPageController.refresh();
                  case 3:
                    return invitesPageController.refresh();
                  case 4:
                    return bansPageControler.refresh();
                }
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      toolbarHeight: 40,
                      pinned: true,
                      title: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                t.general.members,
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
                                  return NavigateIconButton(
                                    icon: FontAwesomeIcons.envelope,
                                    onPressed: showUsersPicker,
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(60),
                        child: CustomTabBar(
                          tabs: tabs
                              .map((e) => switch (e) {
                                    'moderators' => t.general.moderators,
                                    'members' => t.general.members,
                                    'requests' => t.general.requests,
                                    'invites' => t.general.invites,
                                    _ => t.general.bans,
                                  })
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: tabs
                      .map(
                        (e) => Builder(
                          builder: (context) => MembersPage(
                            pagingController: switch (e) {
                              'moderators' => moderatorsPageController,
                              'members' => membersPageController,
                              'requests' => requestsPageController,
                              'bans' => bansPageControler,
                              _ => invitesPageController,
                            },
                            onAction: (actionType, _) {
                              switch (actionType) {
                                case GroupMemberCardActionType.accept:
                                  membersPageController.refresh();
                                  requestsPageController.refresh();
                                  return;
                                case GroupMemberCardActionType.ban:
                                case GroupMemberCardActionType.unban:
                                  membersPageController.refresh();
                                  bansPageControler.refresh();
                                  return;
                                case GroupMemberCardActionType.kick:
                                  membersPageController.refresh();
                                  return;
                                case GroupMemberCardActionType.revoke:
                                  invitesPageController.refresh();
                                  return;
                                case GroupMemberCardActionType.removeMod:
                                case GroupMemberCardActionType.promote:
                                  moderatorsPageController.refresh();
                                  membersPageController.refresh();
                                  return;
                              }
                            },
                            groupId: groupId,
                            membersType: e,
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
    required this.groupId,
    required this.membersType,
    required this.pagingController,
    this.onAction,
  });
  final PagingController<String?, GroupMember> pagingController;
  final String groupId;
  final String membersType;
  final void Function(GroupMemberCardActionType, String)? onAction;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final controller = useTextEditingController();
    final query = useState('');

    useEffect(() {
      controller.addListener(() {
        query.value = controller.text;
        pagingController.refresh();
      });
      return () => null;
    }, []);

    final fetchPage = useCallback((String? cursor) async {
      try {
        PaginationResponse<GroupMember, dynamic> data;
        if (membersType == 'invites') {
          data = await GetIt.I<GroupRepository>().fetchGroupInvites(
            groupId: groupId,
            cursor: cursor,
            query: controller.text,
          );
        } else if (membersType == 'bans') {
          data = await GetIt.I<GroupRepository>().fetchGroupBans(
            groupId: groupId,
            cursor: cursor,
            query: controller.text,
          );
        } else {
          data = await GetIt.I<GroupRepository>().fetchGroupMembers(
            groupId: groupId,
            cursor: cursor,
            type: membersType,
            query: controller.text,
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
    }, [query.value]);

    useEffect(() {
      pagingController.addPageRequestListener(fetchPage);

      return () => pagingController.removePageRequestListener(fetchPage);
    }, [fetchPage]);

    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SearchBar(
              controller: controller,
              hintText: t.placeholder.search,
            ),
          ),
        ),
        PagedSliverList(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<GroupMember>(
            noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
            itemBuilder: (context, item, index) => GroupMemberCard(
              onDone: (actionType) => onAction?.call(actionType, item.uid),
              groupId: groupId,
              member: item,
              showAccept: membersType == 'requests',
              showUndoInvite: membersType == 'invites',
              showKick: membersType == 'members' || membersType == 'bans',
              showBan: membersType == 'members',
              showRemoveMod: membersType == 'moderators',
              showPromote: membersType == 'members',
              showUnban: membersType == 'bans',
            ),
          ),
        ),
      ],
    );
  }
}
