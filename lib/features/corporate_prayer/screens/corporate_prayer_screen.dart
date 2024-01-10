import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/features/common/screens/empty_prayers_screen.dart';
import 'package:prayer/features/common/widgets/parseable_text.dart';
import 'package:prayer/features/corporate_prayer/providers/corporate_prayer_provider.dart';
import 'package:prayer/features/corporate_prayer/widgets/corporate_notification_subscribe_button.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/prayer/widgets/prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/fab.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/user/widgets/user_chip.dart';
import 'package:prayer/features/common/sheets/confirm_menu_form.dart';
import 'package:prayer/features/corporate_prayer/widgets/sheets/corporate_prayer_duration.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CorporatePrayerScreen extends HookConsumerWidget {
  const CorporatePrayerScreen({
    super.key,
    required this.prayerId,
  });

  final String prayerId;

  Jiffy parseFromDateTime(DateTime date) {
    date = date.toLocal();
    return Jiffy.parseFromMap({
      Unit.year: date.year,
      Unit.month: date.month,
      Unit.day: date.day,
    });
  }

  CorporatePrayerDurationStatus? getProgressStatus(
      {Jiffy? startedAt, Jiffy? endedAt}) {
    final now = Jiffy.now().toLocal();
    if (startedAt == null && endedAt == null) {
      return null;
    } else if (startedAt == null) {
      if (now.isSameOrBefore(endedAt!, unit: Unit.day)) {
        return CorporatePrayerDurationStatus.praying;
      }
      return CorporatePrayerDurationStatus.prayed;
    } else if (endedAt == null) {
      if (now.isSameOrAfter(startedAt, unit: Unit.day)) {
        return CorporatePrayerDurationStatus.praying;
      }
      return CorporatePrayerDurationStatus.preparing;
    } else {
      if (now.isBetween(startedAt.subtract(days: 1), endedAt.add(days: 1),
          unit: Unit.day)) {
        return CorporatePrayerDurationStatus.praying;
      } else if (now.isBefore(startedAt, unit: Unit.day)) {
        return CorporatePrayerDurationStatus.preparing;
      }
      return CorporatePrayerDurationStatus.prayed;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(corporatePrayerProvider(prayerId));
    final pagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final startedAt = snapshot.value?.startedAt == null
        ? null
        : parseFromDateTime(snapshot.value!.startedAt!);
    final endedAt = snapshot.value?.endedAt == null
        ? null
        : parseFromDateTime(snapshot.value!.endedAt!);

    final checkingMember = useState(false);
    final prayingStatus = useMemoized(
        () => getProgressStatus(startedAt: startedAt, endedAt: endedAt),
        [snapshot.value, startedAt, endedAt]);

    final text = useMemoized(
        () => switch (prayingStatus) {
              CorporatePrayerDurationStatus.prayed =>
                S.of(context).corporatePrayerPrayed,
              CorporatePrayerDurationStatus.praying =>
                S.of(context).corporatePrayerPraying,
              _ => S.of(context).corporatePrayerPreparing,
            },
        [prayingStatus]);

    final color = useMemoized(
        () => switch (prayingStatus) {
              CorporatePrayerDurationStatus.preparing => [
                  Theme.of(context).disabledColor,
                  Theme.of(context).colorScheme.onBackground,
                ],
              CorporatePrayerDurationStatus.praying => [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
              _ => [
                  Theme.of(context).colorScheme.inverseSurface,
                  Theme.of(context).colorScheme.onInverseSurface,
                ],
            },
        [prayingStatus]);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        cupertino: (context, platform) => CupertinoNavigationBarData(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        leading: NavigateBackButton(),
        title: Text(S.of(context).corporate),
        trailingActions: [
          if (snapshot.value?.userId == FirebaseAuth.instance.currentUser?.uid)
            PullDownButton(
                itemBuilder: (context) => [
                      PullDownMenuItem(
                        onTap: () async {
                          if (snapshot.value != null) {
                            final resp = await context.push(
                              Uri(path: '/form/corporate', queryParameters: {
                                'groupId': snapshot.value!.groupId,
                              }).toString(),
                              extra: snapshot.value,
                            );
                            if (resp == true) {
                              return ref.refresh(
                                  corporatePrayerProvider(prayerId).future);
                            }
                          }
                        },
                        title: S.of(context).edit,
                        icon: FontAwesomeIcons.penToSquare,
                      ),
                      PullDownMenuItem(
                        onTap: () async {
                          final response = await ConfirmMenuForm.show(
                            context,
                            title: S.of(context).titleDeleteCorporatePrayer,
                            subtitle:
                                S.of(context).titleConfirmDeleteCorporatePrayer,
                            description: [
                              S.of(context).descriptionDeleteCorporatePrayer
                            ],
                            icon: FontAwesomeIcons.trash,
                          );
                          if (response == true) {
                            GetIt.I<PrayerRepository>()
                                .deleteCorporatePrayer(prayerId: prayerId);
                            context.pop();
                          }
                        },
                        title: S.of(context).delete,
                        icon: FontAwesomeIcons.trash,
                        isDestructive: true,
                      ),
                    ],
                buttonBuilder: (context, showMenu) {
                  return NavigateIconButton(
                    onPressed: showMenu,
                    icon: FontAwesomeIcons.solidEllipsisVertical,
                  );
                })
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            notificationPredicate: (notification) => notification.depth == 1,
            onRefresh: () async {
              pagingController.refresh();
              return ref.refresh(corporatePrayerProvider(prayerId).future);
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled: snapshot.valueOrNull == null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShrinkingButton(
                                      onTap: () {
                                        if (snapshot.value?.groupId != null) {
                                          context.push(
                                              '/groups/${snapshot.value!.groupId}');
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          FaIcon(
                                            FontAwesomeIcons.lightUsers,
                                            size: 13,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(snapshot.value?.group?.name ??
                                              ''),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    UserChip(
                                      uid: snapshot.value?.userId,
                                      name: snapshot.value?.user?.name,
                                      profile: snapshot.value?.user?.profile,
                                      username: snapshot.value?.user?.username,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: CorporateNotificationSubscribeButton(
                                      corporateId: prayerId,
                                    ),
                                  ),
                                  if (prayingStatus != null)
                                    ShrinkingButton(
                                      onTap: () {
                                        CorporatePrayerDuration.show(
                                          context,
                                          status: getProgressStatus(
                                            startedAt: startedAt,
                                            endedAt: endedAt,
                                          )!,
                                          startedAt: startedAt,
                                          endedAt: endedAt,
                                          prayersCount:
                                              snapshot.value?.prayersCount ?? 0,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: color[0],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          text,
                                          style: TextStyle(color: color[1]),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.value?.title ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          if (snapshot.value == null ||
                              snapshot.value?.description != null)
                            ParseableText(
                              snapshot.value?.description ?? '',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (snapshot.value?.prayers != null)
                            ...snapshot.value!.prayers!
                                .asMap()
                                .entries
                                .map((entry) => Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .disabledColor),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${entry.key + 1}.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              entry.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: PrayersScreen(
                physics: const NeverScrollableScrollPhysics(),
                noItemsFoundIndicatorBuilder: (p0) => EmptyPrayersScreen(
                  title: S.of(context).emptyCorporatePrayerTitle,
                  description: S.of(context).emptyCorporatePrayerDescription,
                ),
                fetchFn: (cursor) =>
                    GetIt.I<PrayerRepository>().fetchPrayersFromCorporatePrayer(
                  prayerId: prayerId,
                  cursor: cursor,
                ),
                pagingController: pagingController,
              ),
            ),
          ),
          if (snapshot.value != null)
            FAB(
              onTap: () async {
                checkingMember.value = true;
                ref
                    .read(GroupNotifierProvider(snapshot.value!.groupId))
                    .whenData((value) {
                  checkingMember.value = false;
                  if (value == null) {
                    GlobalSnackBar.show(context,
                        message: S.of(context).errorUnknown);
                    return;
                  } else if (value.acceptedAt == null) {
                    GlobalSnackBar.show(context,
                        message: S.of(context).errorNeedPermissionToPost);
                    return;
                  }
                });
                final resp =
                    context.push(Uri(path: '/form/prayer', queryParameters: {
                  'groupId': snapshot.value!.groupId,
                  'corporateId': snapshot.value!.id,
                }).toString());
                if (resp == true) {
                  pagingController.refresh();
                }
              },
              loading: checkingMember.value,
            ),
        ],
      ),
    );
  }
}
