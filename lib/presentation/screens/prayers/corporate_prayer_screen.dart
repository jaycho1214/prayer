import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/corporate_prayer_model.dart';
import 'package:prayer/presentation/screens/prayers/prayers_screen.dart';
import 'package:prayer/presentation/widgets/button/fab.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_menu_form.dart';
import 'package:prayer/presentation/widgets/sheets/corporate_prayer_duration.dart';
import 'package:prayer/presentation/widgets/sheets/reminder_detail.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/providers/group/group_provider.dart';
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
      if (now.isBetween(startedAt, endedAt.add(days: 1), unit: Unit.day)) {
        return CorporatePrayerDurationStatus.praying;
      } else if (now.isBefore(startedAt, unit: Unit.day)) {
        return CorporatePrayerDurationStatus.preparing;
      }
      return CorporatePrayerDurationStatus.prayed;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshKey = useState(0);
    final fetchFn = useMemoized(
        () => GetIt.I<PrayerRepository>().fetchCorporatePrayer(prayerId),
        [refreshKey.value]);
    final snapshot = useFuture(
      fetchFn,
      initialData: CorporatePrayer.placeholder,
      preserveState: false,
    );
    final pagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final startedAt = snapshot.data?.startedAt == null
        ? null
        : parseFromDateTime(snapshot.data!.startedAt!);
    final endedAt = snapshot.data?.endedAt == null
        ? null
        : parseFromDateTime(snapshot.data!.endedAt!);

    final checkingMember = useState(false);
    final prayingStatus = useMemoized(
        () => getProgressStatus(startedAt: startedAt, endedAt: endedAt),
        [snapshot.data, startedAt, endedAt]);

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
                  MyTheme.disabled,
                  MyTheme.onPrimary
                ],
              CorporatePrayerDurationStatus.praying => [
                  MyTheme.primary,
                  MyTheme.onPrimary
                ],
              _ => [MyTheme.onPrimary, MyTheme.surface],
            },
        [prayingStatus]);

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        backgroundColor: MyTheme.surface,
        leading: NavigateBackButton(),
        title: Text(S.of(context).corporate),
        trailingActions: [
          if (snapshot.data?.userId == FirebaseAuth.instance.currentUser?.uid)
            PullDownButton(
                itemBuilder: (context) => [
                      PullDownMenuItem(
                        onTap: () async {
                          if (snapshot.data != null) {
                            final resp = await context.push(
                                Uri(path: '/form/corporate', queryParameters: {
                                  'groupId': snapshot.data!.groupId,
                                }).toString(),
                                extra: snapshot.data);
                            if (resp == true) {
                              refreshKey.value += 1;
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
              refreshKey.value += 1;
              pagingController.refresh();
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled:
                        snapshot.connectionState == ConnectionState.waiting ||
                            snapshot.data == null,
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
                                        if (snapshot.data?.groupId != null) {
                                          context.push(
                                              '/groups/${snapshot.data!.groupId}');
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          FaIcon(
                                            FontAwesomeIcons.lightUsers,
                                            size: 13,
                                            color: MyTheme.onPrimary,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                              snapshot.data?.group?.name ?? ''),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    UserChip(
                                      uid: snapshot.data?.userId,
                                      name: snapshot.data?.user?.name,
                                      profile: snapshot.data?.user?.profile,
                                      username: snapshot.data?.user?.username,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  if (snapshot.data?.reminder != null)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: ShrinkingButton(
                                        onTap: () => ReminderDetailSheet.show(
                                          context,
                                          reminder: snapshot.data!.reminder!,
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.bell,
                                          size: 20,
                                          color: MyTheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  if (prayingStatus != null)
                                    ShrinkingButton(
                                      onTap: () {
                                        CorporatePrayerDuration.show(
                                          context,
                                          status: getProgressStatus(
                                              startedAt: startedAt,
                                              endedAt: endedAt)!,
                                          startedAt: startedAt,
                                          endedAt: endedAt,
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
                            snapshot.data?.title ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          if (snapshot.data == null ||
                              snapshot.data?.description != null)
                            Text(
                              snapshot.data?.description ?? '',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          if (snapshot.data?.prayers != null)
                            ...snapshot.data!.prayers!
                                .asMap()
                                .entries
                                .map((entry) => Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: MyTheme.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${entry.key + 1}.',
                                            style: TextStyle(
                                              color: MyTheme.surface,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 17,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              entry.value,
                                              style: TextStyle(),
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
                  fetchFn: (cursor) => GetIt.I<PrayerRepository>()
                          .fetchPrayersFromCorporatePrayer(
                        prayerId: prayerId,
                        cursor: cursor,
                      ),
                  pagingController: pagingController),
            ),
          ),
          if (snapshot.data != null)
            FAB(
              onTap: () async {
                checkingMember.value = true;
                ref
                    .read(GroupNotifierProvider(snapshot.data!.groupId))
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
                  'groupId': snapshot.data!.groupId,
                  'corporateId': snapshot.data!.id,
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
