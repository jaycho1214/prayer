import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/bloc/group/group_bloc.dart';
import 'package:prayer/bloc/group/group_state.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group_member_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/user/group_member_card.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupMembersScreen extends HookWidget {
  const GroupMembersScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context) {
    final group = (context.read<GroupBloc>().state as GroupStateLoaded).group;
    final promoting = useState(false);
    final membersPageController =
        usePagingController<int?, GroupMember>(firstPageKey: null);
    final moderatorsPageController =
        usePagingController<int?, GroupMember>(firstPageKey: null);
    final requestsPageController =
        usePagingController<int?, GroupMember>(firstPageKey: null);

    return DefaultTabController(
      length: group.moderator != null && group.membershipType != 'open' ? 3 : 2,
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
                }
                return null;
              },
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      pinned: true,
                      surfaceTintColor: MyTheme.surface,
                      backgroundColor: MyTheme.surface,
                      title: Text(
                        'Members',
                        style: platformThemeData(
                          context,
                          material: (ThemeData data) =>
                              data.textTheme.headlineSmall,
                          cupertino: (data) => data.textTheme.navTitleTextStyle,
                        ),
                      ),
                      leading: NavigateBackButton(),
                      actions: [
                        if (group.adminId ==
                            FirebaseAuth.instance.currentUser?.uid)
                          Container(
                            decoration: promoting.value
                                ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyTheme.primary,
                                  )
                                : null,
                            child: Center(
                              child: NavigateIconButton(
                                icon: FontAwesomeIcons.userPilot,
                                onPressed: () =>
                                    promoting.value = !promoting.value,
                              ),
                            ),
                          ),
                      ],
                      bottom: TabBar(
                        tabs: [
                          Tab(text: 'Moderators'),
                          Tab(text: 'Members'),
                          if (group.moderator != null &&
                              group.membershipType != 'open')
                            Tab(text: 'Requests'),
                        ],
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: ['moderators', 'members', 'requests']
                      .map(
                        (e) => Builder(
                          builder: (context) => CustomScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverOverlapInjector(
                                  handle: NestedScrollView
                                      .sliverOverlapAbsorberHandleFor(context)),
                              MembersPage(
                                pagingController: switch (e) {
                                  'moderators' => moderatorsPageController,
                                  'members' => membersPageController,
                                  _ => requestsPageController,
                                },
                                groupId: groupId,
                                membersType: e,
                                promote:
                                    e != 'members' ? false : promoting.value,
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
    required this.groupId,
    required this.membersType,
    required this.pagingController,
    this.promote,
  });

  final PagingController<int?, GroupMember> pagingController;
  final String groupId;
  final String membersType;
  final bool? promote;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final fetchPage = useCallback((int? cursor) async {
      try {
        final data = await context.read<GroupRepository>().fetchGroupMembers(
              groupId: groupId,
              cursor: cursor,
              type: membersType,
            );
        if (data['cursor'] != null) {
          pagingController.appendPage(data['members'], data['cursor']);
        } else {
          pagingController.appendLastPage(data['members']);
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
          groupId: groupId,
          member: item,
          showAccept: membersType == 'requests',
          showPromote: promote ?? false,
        ),
      ),
    );
  }
}
