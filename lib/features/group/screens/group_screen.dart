import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/common/screens/empty_prayers_screen.dart';
import 'package:prayer/features/common/widgets/parseable_text.dart';
import 'package:prayer/features/common/widgets/statistics_text.dart';
import 'package:prayer/features/group/providers/group_notification_provider.dart';
import 'package:prayer/features/group/widgets/group_member_ban_Card.dart';
import 'package:prayer/features/group/widgets/group_notification_subscribe_button.dart';
import 'package:prayer/features/group/widgets/group_share_button.dart';
import 'package:prayer/features/prayer/widgets/forms/post_prayer_type_picker.dart';
import 'package:prayer/i18n/strings.g.dart';
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
          GlobalSnackBar.show(context, message: t.error.unknown);
        },
        loading: () {},
      );
    });

    final data = ref.watch(GroupNotifierProvider(groupId));
    final group = data.value ?? Group.placeholder;

    return PlatformScaffold(
      appBar: PlatformAppBar(
        cupertino: (context, platform) => CupertinoNavigationBarData(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.general.group),
            const SizedBox(width: 10),
            PrimaryTextButton(
                onTap: () => GroupInformationSheet.show(context, groupId),
                text: switch (group.membershipType) {
                  'restricted' => t.general.restricted,
                  'private' => t.general.private,
                  _ => t.general.open,
                }),
          ],
        ),
        leading: NavigateBackButton(),
        trailingActions: [
          Center(
            child: PullDownButton(
              itemBuilder: (context) => [
                PullDownMenuItem(
                  onTap: () => GroupInformationSheet.show(context, groupId),
                  title: t.general.about,
                  icon: FontAwesomeIcons.circleInfo,
                  enabled: data.value != null,
                ),
                PullDownMenuItem(
                  onTap: () {
                    context.push('/groups/$groupId/members');
                  },
                  title: t.general.members,
                  icon: FontAwesomeIcons.lightUsers,
                ),
                PullDownMenuItem(
                  onTap: () {
                    context.push(Uri(
                        path: '/report',
                        queryParameters: {'groupId': groupId}).toString());
                  },
                  title: t.general.report,
                  icon: FontAwesomeIcons.flag,
                  isDestructive: true,
                ),
                if (group.adminId == FirebaseAuth.instance.currentUser?.uid)
                  PullDownMenuItem(
                    onTap: () => context.push('/form/group', extra: group),
                    title: t.general.edit,
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
                await Future.wait([
                  ref.refresh(
                      groupNotificationNotifierProvider(groupId).future),
                  ref.refresh(groupNotifierProvider(groupId).future)
                ]);
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
                              if (data.value?.bannedAt != null) GroupBanCard(),
                              if (data.value?.userBannedAt != null)
                                GroupMemberBanCard(),
                              GroupBannerImage(
                                banner: group.banner,
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
                                      ParseableText(
                                        group.description!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
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
                                            text: t.general.members,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        StatisticsText(
                                            value: group.prayersCount,
                                            text: t.general.prayers),
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
                          tabs: [t.general.prayer, t.general.corporate],
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
                                  t.error.viewNoPermission(
                                      membershipType: group.membershipType),
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
                                    noItemsFoundIndicatorBuilder: (p0) =>
                                        EmptyPrayersScreen(
                                      title: t.empty.groupPrayer.title,
                                      description:
                                          t.empty.groupPrayer.description,
                                      buttonText: t.empty.groupPrayer.button,
                                      onTap: () => context.push(Uri(
                                          path: '/form/prayer',
                                          queryParameters: {
                                            'groupId': groupId
                                          }).toString()),
                                    ),
                                    pagingController: prayerPagingController,
                                  ),
                                  GroupCorporatePrayersScreen(
                                    noItemsFoundIndicatorBuilder: (p0) =>
                                        EmptyPrayersScreen(
                                      title: t.empty.corporatePrayer.title,
                                      description:
                                          t.empty.corporatePrayer.description,
                                      buttonText: group.moderator == null
                                          ? null
                                          : t.general.create,
                                      onTap: group.moderator == null
                                          ? null
                                          : () => context.push(Uri(
                                                  path: '/form/corporate',
                                                  queryParameters: {
                                                    'groupId': groupId
                                                  }).toString()),
                                    ),
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
                      if (group.acceptedAt == null) {
                        return GlobalSnackBar.show(context,
                            message: t.error.mustBeMemberToPost);
                      }
                      PostPrayerTypePickerResponse? resp;
                      bool? prayer;
                      if (group.moderator != null) {
                        resp = await PostPrayerTypePicker.show(context);
                        if (resp == null) {
                          return;
                        }
                      }
                      prayer = group.moderator == null ||
                          resp == PostPrayerTypePickerResponse.prayer;
                      if (prayer) {
                        final didAdd = await context.push(Uri(
                            path: '/form/prayer',
                            queryParameters: {'groupId': groupId}).toString());
                        if (didAdd == true) {
                          prayerPagingController.refresh();
                        }
                      } else {
                        final didSomething = await context.push(Uri(
                            path: '/form/corporate',
                            queryParameters: {'groupId': groupId}).toString());
                        if (didSomething == true) {
                          corporatePagingController.refresh();
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
