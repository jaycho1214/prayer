import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/common/screens/empty_prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/image_list.dart';
import 'package:prayer/features/common/widgets/parseable_text.dart';
import 'package:prayer/features/prayer/widgets/labels/pinned_label.dart';
import 'package:prayer/features/prayer/widgets/labels/written_by_me.dart';
import 'package:prayer/features/prayer/widgets/open_graph_card.dart';
import 'package:prayer/features/prayer/widgets/prayer_option_button.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/prayer_pray/prayer_pray_model.dart';
import 'package:prayer/features/bible/widgets/bible_card_list.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/pray/widgets/pray_button.dart';
import 'package:prayer/features/user/widgets/user_chip.dart';
import 'package:prayer/features/pray/widgets/pray_card.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/prayer/providers/deleted_prayer_provider.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/utils/formatter.dart';
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

    return KeyboardDismissOnTap(
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 30,
                child: NavigateBackButton(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(t.general.prayer),
                    if (prayer.value?.groupId != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShrinkingButton(
                            onTap: () => context
                                .push('/groups/${prayer.value?.groupId}'),
                            child: Text(
                              prayer.value?.group?.name ?? '',
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.color,
                              ),
                            ),
                          ),
                          if (prayer.value?.corporateId != null) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: FaIcon(
                                FontAwesomeIcons.solidChevronRight,
                                size: 8,
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.color,
                              ),
                            ),
                            ShrinkingButton(
                              onTap: () => context.push(
                                  '/prayers/corporate/${prayer.value?.corporateId}'),
                              child: Text(
                                prayer.value?.corporate?.title ?? '',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.color,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
          cupertino: (context, platform) => CupertinoNavigationBarData(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 0,
              onRefresh: () {
                pagingController.refresh();
                return ref.refresh(prayerNotifierProvider(prayerId).future);
              },
              child: CustomScrollView(
                cacheExtent: 10000,
                slivers: [
                  SliverToBoxAdapter(
                    child: Skeletonizer(
                      enabled: prayer.isLoading ||
                          prayer.value == null ||
                          deletedPrayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (prayer.value?.pinnedBy != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35.0),
                                              child: PinnedLabel(
                                                  pinnedBy:
                                                      prayer.value!.pinnedBy!),
                                            ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              UserChip(
                                                uid: prayer.value?.userId,
                                                name: prayer.value?.user?.name,
                                                profile:
                                                    prayer.value?.user?.profile,
                                                username: prayer
                                                    .value?.user?.username,
                                                anon:
                                                    prayer.value?.anon ?? false,
                                              ),
                                              if (prayer.value?.anon == true &&
                                                  FirebaseAuth.instance
                                                          .currentUser?.uid ==
                                                      prayer.value?.userId)
                                                WrittenByMeLabel(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (prayer.value != null)
                                      PrayerOptionButton(prayer: prayer.value!),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ParseableText(
                                  prayer.value?.value ?? '',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                OpenGraphCard(text: prayer.value?.value ?? ''),
                                if (prayer.value?.verses != null &&
                                    prayer.value!.verses.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: BibleCardList(
                                        verses: prayer.value!.verses),
                                  ),
                                if (prayer.value?.contents != null &&
                                    prayer.value!.contents.length > 0)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ImageList(
                                        images: prayer.value?.contents
                                                .map((e) => e.path)
                                                .toList() ??
                                            []),
                                  ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (prayer.value?.createdAt != null)
                                      Text(
                                        Jiffy.parseFromDateTime(
                                                prayer.value!.createdAt!)
                                            .yMMMdjm,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    Spacer(),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                '${Formatter.formatNumber(prayer.value?.praysCount ?? 0)} ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            ),
                                          ),
                                          TextSpan(
                                            text: t.general.prays,
                                          ),
                                        ],
                                        style: TextStyle(
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                  SliverVisibility(
                    sliver: SliverPadding(
                      padding: const EdgeInsets.only(bottom: 500),
                      sliver: PraysScreen(
                        prayerId: prayerId,
                        pagingController: pagingController,
                      ),
                    ),
                    maintainSize: false,
                    maintainInteractivity: false,
                    maintainState: false,
                    visible: !deletedPrayer,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PrayButton(
                prayerId: prayerId,
                onPrayed: () => pagingController.refresh(),
              ),
            ),
          ],
        ),
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
      }).catchError((e, st) {
        talker.handle(e, st,
            "[PrayerScreen] Failed to fetch next page of prayer prays: (prayerId: $prayerId)");
        pagingController.error = e;
      });
    }, [pagingController]);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () => pagingController.removePageRequestListener(requestPage);
    }, [pagingController]);

    return PagedSliverList<int?, PrayerPray>(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        noItemsFoundIndicatorBuilder: (context) => EmptyPrayersScreen(
          title: t.empty.main.title,
          description: t.empty.main.description,
        ),
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
                GlobalSnackBar.show(context, message: t.error.deletePray);
              }
            }).catchError((e) {
              GlobalSnackBar.show(context, message: t.error.deletePray);
            });
          },
        ),
      ),
    );
  }
}
