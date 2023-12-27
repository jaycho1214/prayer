import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/image_list.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/prayer_pray/prayer_pray_model.dart';
import 'package:prayer/features/bible/widgets/bible_card_list.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/pray/widgets/pray_button.dart';
import 'package:prayer/features/user/widgets/user_chip.dart';
import 'package:prayer/features/pray/widgets/pray_card.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/prayer/providers/deleted_prayer_provider.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/utils/formatter.dart';
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
                                                      FontAwesomeIcons
                                                          .lightUsers,
                                                      size: 13,
                                                      color: MyTheme.onPrimary,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(prayer.value?.group
                                                            ?.name ??
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
                                                      FontAwesomeIcons
                                                          .chevronRight,
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
                                          username:
                                              prayer.value?.user?.username,
                                          anon: prayer.value?.anon ?? false,
                                        ),
                                      ],
                                    ),
                                  ),
                                  PullDownButton(
                                      itemBuilder: (context) => [
                                            PullDownMenuHeader(
                                              leading: UserProfileImage(
                                                  profile: prayer
                                                      .value?.user?.profile),
                                              title:
                                                  '@${prayer.value?.user?.username}',
                                              icon: FontAwesomeIcons.circleUser,
                                              onTap: () => context.push(Uri(
                                                  path: '/users',
                                                  queryParameters: {
                                                    'uid':
                                                        prayer.value?.user?.uid
                                                  }).toString()),
                                            ),
                                            PullDownMenuDivider.large(),
                                            if (prayer.value?.userId ==
                                                FirebaseAuth
                                                    .instance.currentUser?.uid)
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
                                            PullDownMenuItem(
                                              onTap: () {
                                                context.push(Uri(
                                                    path: '/report',
                                                    queryParameters: {
                                                      'prayerId': prayerId
                                                    }).toString());
                                              },
                                              title: S.of(context).report,
                                              icon: FontAwesomeIcons.flag,
                                              isDestructive: true,
                                            ),
                                          ],
                                      buttonBuilder: (context, showMenu) {
                                        return NavigateIconButton(
                                          onPressed: showMenu,
                                          icon:
                                              FontAwesomeIcons.ellipsisVertical,
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
                              if (prayer.value?.verses != null &&
                                  prayer.value!.verses.length > 0)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
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
                                      style: TextStyle(
                                        color: MyTheme.placeholderText,
                                      ),
                                    ),
                                  Spacer(),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text:
                                            '${Formatter.formatNumber(prayer.value?.praysCount ?? 0)} ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      TextSpan(
                                        text: S.of(context).prays,
                                        style: TextStyle(
                                          color: MyTheme.placeholderText,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: MyTheme.disabled),
                      ],
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
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: PrayButton(
                prayerId: prayerId,
                onPrayed: () => pagingController.refresh(),
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

    return PagedListView<int?, PrayerPray>(
      physics: const NeverScrollableScrollPhysics(),
      pagingController: pagingController,
      padding: const EdgeInsets.only(bottom: 200),
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