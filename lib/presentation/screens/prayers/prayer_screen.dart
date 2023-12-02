import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/prayer_pray_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/pray_button.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/form/pray_card.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/providers/prayer/deleted_prayer_provider.dart';
import 'package:prayer/providers/prayer/prayer_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerScreen extends HookConsumerWidget {
  const PrayerScreen({
    super.key,
    required this.prayerId,
  });

  final String prayerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayer = ref.watch(prayerNotifierProvider(prayerId));
    final deletedPrayer =
        ref.watch(deletedPrayerNotifierProvider).indexOf(prayerId) != -1;
    final pagingController =
        usePagingController<int?, PrayerPray>(firstPageKey: null);

    ref.listen(prayerNotifierProvider(prayerId), (_, next) {
      pagingController.refresh();
    });

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        backgroundColor: MyTheme.surface,
        leading: NavigateBackButton(),
        title: Text(S.of(context).prayer),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            notificationPredicate: (notification) => notification.depth == 1,
            onRefresh: () {
              pagingController.refresh();
              return ref.refresh(prayerNotifierProvider(prayerId).future);
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled: prayer.isLoading ||
                        prayer.value == null ||
                        deletedPrayer,
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
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (prayer.value?.group != null)
                                          ShrinkingButton(
                                            onTap: () {
                                              context.push(
                                                  '/groups/${prayer.value?.groupId}');
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
                                                    prayer.value?.group?.name ??
                                                        ''),
                                              ],
                                            ),
                                          ),
                                        if (prayer.value?.corporate != null)
                                          ShrinkingButton(
                                            onTap: () {
                                              context.push(
                                                  '/prayers/corporate/${prayer.value?.corporateId}');
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 5),
                                                FaIcon(
                                                  FontAwesomeIcons.chevronRight,
                                                  size: 10,
                                                  color: MyTheme.onPrimary,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(prayer.value?.corporate
                                                        ?.title ??
                                                    ''),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    UserChip(
                                      uid: prayer.value?.userId,
                                      name: prayer.value?.user?.name,
                                      profile: prayer.value?.user?.profile,
                                      username: prayer.value?.user?.username,
                                      anon: prayer.value?.anon ?? false,
                                    ),
                                  ],
                                ),
                              ),
                              if (prayer.value?.userId ==
                                  FirebaseAuth.instance.currentUser?.uid)
                                PullDownButton(
                                    itemBuilder: (context) => [
                                          PullDownMenuItem(
                                            onTap: () {
                                              GetIt.I<PrayerRepository>()
                                                  .deletePrayer(
                                                      prayerId: prayerId);
                                              ref
                                                  .read(
                                                      deletedPrayerNotifierProvider
                                                          .notifier)
                                                  .add(prayerId);
                                              context.pop('deleted');
                                            },
                                            title: S.of(context).delete,
                                            icon: FontAwesomeIcons.trash,
                                            isDestructive: true,
                                          ),
                                        ],
                                    buttonBuilder: (context, showMenu) {
                                      return NavigateIconButton(
                                        onPressed: showMenu,
                                        icon: FontAwesomeIcons.ellipsisVertical,
                                      );
                                    })
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            prayer.value?.value ?? '',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (prayer.value?.media != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: prayer.value!.media!,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: deletedPrayer
                  ? const SizedBox()
                  : PraysScreen(
                      prayerId: prayerId,
                      pagingController: pagingController,
                    ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: PrayButton(
                      prayerId: prayerId,
                    ),
                  ),
                  const SizedBox(width: 20),
                  PrayButton(
                    prayerId: prayerId,
                    silent: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PraysScreen extends HookConsumerWidget {
  const PraysScreen({
    super.key,
    required this.prayerId,
    required this.pagingController,
  });

  final String prayerId;
  final PagingController<int?, PrayerPray> pagingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final requestPage = useCallback((int? cursor) {
      GetIt.I<PrayerRepository>()
          .fetchPrayerPrays(
        prayerId: prayerId,
        cursor: cursor,
      )
          .then((data) {
        if (data.cursor == null) {
          pagingController.appendLastPage(data.items ?? []);
        } else {
          pagingController.appendPage(data.items ?? [], data.cursor);
        }
      }).catchError((e) {
        talker.error("Error on fetching next page of prayer prays: $e");
        pagingController.error = e;
      });
    }, [pagingController]);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () => pagingController.removePageRequestListener(requestPage);
    }, [pagingController]);

    return PagedListView<int?, PrayerPray>(
      physics: const NeverScrollableScrollPhysics(),
      pagingController: pagingController,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 200),
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, item, index) => PrayCard(
          pray: item,
          onDelete: () async {
            await GetIt.I<PrayerRepository>()
                .deletePrayerPray(prayerId: prayerId, prayId: item.id)
                .then((value) {
              if (value) {
                ref.invalidate(prayerNotifierProvider(prayerId));
                pagingController.value = PagingState(
                  nextPageKey: pagingController.value.nextPageKey,
                  itemList: [...(pagingController.value.itemList ?? [])]
                    ..removeAt(index),
                  error: pagingController.value.error,
                );
              } else {
                GlobalSnackBar.show(context,
                    message: S.of(context).errorDeletePray);
              }
            }).catchError((e) {
              GlobalSnackBar.show(context,
                  message: S.of(context).errorDeletePray);
            });
          },
        ),
      ),
    );
  }
}
