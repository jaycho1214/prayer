import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/parseable_text.dart';
import 'package:prayer/features/common/widgets/statistics_text.dart';
import 'package:prayer/features/group/widgets/group_notification_subscribe_button.dart';
import 'package:prayer/features/group/widgets/group_share_button.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/corporate_prayer/widgets/group_corporate_prayers_screen.dart';
import 'package:prayer/features/prayer/widgets/prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/fab.dart';
import 'package:prayer/features/group/widgets/join_button.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/group/widgets/group_ban_card.dart';
import 'package:prayer/features/common/widgets/nested_scroll_tab_bar.dart';
import 'package:prayer/features/group/widgets/sheets/group_information_sheet.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
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
          GlobalSnackBar.show(context, message: S.of(context).errorUnknown);
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).group),
            const SizedBox(width: 10),
            PrimaryTextButton(
                onTap: () {
                  if (data.value != null) {
                    GroupInformationSheet.show(context, groupId);
                  }
                },
                text: switch (group.membershipType) {
                  'restricted' => S.of(context).restricted,
                  'private' => S.of(context).private,
                  _ => S.of(context).open,
                }),
          ],
        ),
        leading: NavigateBackButton(),
        trailingActions: [
          Center(
            child: PullDownButton(
              itemBuilder: (context) => [
                PullDownMenuItem(
                  onTap: () {
                    context.push('/groups/$groupId/members');
                  },
                  title: S.of(context).members,
                  icon: FontAwesomeIcons.lightUsers,
                ),
                PullDownMenuItem(
                  onTap: () {
                    context.push(Uri(
                        path: '/report',
                        queryParameters: {'groupId': groupId}).toString());
                  },
                  title: S.of(context).report,
                  icon: FontAwesomeIcons.flag,
                  isDestructive: true,
                ),
                if (group.adminId == FirebaseAuth.instance.currentUser?.uid)
                  PullDownMenuItem(
                    onTap: () => context.push('/form/group', extra: group),
                    title: S.of(context).edit,
                    icon: FontAwesomeIcons.penToSquare,
                    enabled:
                        group.adminId == FirebaseAuth.instance.currentUser?.uid,
                    isDestructive: true,
                  ),
              ],
              buttonBuilder: (context, showMenu) {
                return NavigateIconButton(
                  onPressed: showMenu,
                  icon: FontAwesomeIcons.solidEllipsisVertical,
                );
              },
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              notificationPredicate: (notification) =>
                  group.membershipType != 'open' && group.acceptedAt == null
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
                          enabled: data.value == null ||
                              data.isLoading ||
                              data.hasError,
                          child: Column(
                            children: [
                              GroupBannerImage(
                                banner: group.banner,
                              ),
                              if (data.value?.bannedAt != null) GroupBanCard(),
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
                                      ParseableText(
                                        group.description!,
                                        style: TextStyle(
                                          color: MyTheme.placeholderText,
                                          fontSize: 13,
                                        ),
                                      ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ShrinkingButton(
                                          onTap: () => context
                                              .push('/groups/$groupId/members'),
                                          child: StatisticsText(
                                              value: group.membersCount,
                                              text: S.of(context).members),
                                        ),
                                        const SizedBox(width: 15),
                                        StatisticsText(
                                            value: group.prayersCount,
                                            text: S.of(context).prayers),
                                        Spacer(),
                                        if (group.acceptedAt != null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child:
                                                GroupNotificationSubscribeButton(
                                                    groupId: groupId),
                                          ),
                                        GroupShareButton(groupId: groupId),
                                        const SizedBox(width: 10),
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
                          tabs: [S.of(context).prayer, S.of(context).corporate],
                        ),
                      ),
                    ],
                    body: data.value == null
                        ? Center(
                            child: const CircularProgressIndicator.adaptive())
                        : group.membershipType != 'open' &&
                                group.acceptedAt == null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  S.of(context).errorNeedPermissionToView(
                                      group.membershipType),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : TabBarView(
                                children: [
                                  PrayersScreen(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    fetchFn: (cursor) =>
                                        GetIt.I<PrayerRepository>()
                                            .fetchGroupPrayers(
                                                groupId: groupId),
                                    pagingController: prayerPagingController,
                                  ),
                                  GroupCorporatePrayersScreen(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    groupId: groupId,
                                    pagingController: corporatePagingController,
                                  ),
                                ],
                              ),
                  ),
                  FAB(
                    onTap: () async {
                      if (DefaultTabController.of(context).index == 0) {
                        if (group.acceptedAt == null) {
                          GlobalSnackBar.show(context,
                              message: "Only members can post prayers.");
                        } else {
                          final didAdd = await context.push(Uri(
                                  path: '/form/prayer',
                                  queryParameters: {'groupId': groupId})
                              .toString());
                          if (didAdd == true) {
                            prayerPagingController.refresh();
                          }
                        }
                      } else if (DefaultTabController.of(context).index == 1) {
                        if (group.moderator == null) {
                          GlobalSnackBar.show(context,
                              message:
                                  S.of(context).errorMustBeModeratorToPost);
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
