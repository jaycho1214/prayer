import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/prayer_model.dart';
import 'package:prayer/model/prayer_pray_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/pray_button.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/pray/pray_large_card.dart';
import 'package:prayer/presentation/widgets/pray/pray_slim_card.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_context_menu/super_context_menu.dart';

class PrayerScreen extends HookWidget {
  const PrayerScreen({
    super.key,
    required this.prayerId,
  });

  final String prayerId;

  @override
  Widget build(BuildContext context) {
    final refreshKey = useState(0);
    final snapshot = useFuture(
      useMemoized(() => context.read<PrayerRepository>().fetchPrayer(prayerId),
          [refreshKey.value]),
      initialData: Prayer.placeholder,
    );
    final pagingController =
        usePagingController<int?, PrayerPray>(firstPageKey: null);
    final hasPrayed = useState(snapshot.data?.hasPrayed != null);
    final praysCount = useState(snapshot.data?.praysCount ?? 0);

    final onPray = useCallback(() {
      hasPrayed.value = true;
      praysCount.value += 1;
      pagingController.refresh();
    }, []);

    useEffect(() {
      hasPrayed.value = snapshot.data?.hasPrayed != null;
      praysCount.value = snapshot.data?.praysCount ?? 0;
      return () => null;
    }, [snapshot.data, refreshKey.value]);

    return PlatformScaffold(
      backgroundColor: MyTheme.surface,
      appBar: PlatformAppBar(
        backgroundColor: MyTheme.surface,
        leading: NavigateBackButton(),
        title: Text("Prayer"),
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
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (snapshot.data?.group != null)
                                          ShrinkingButton(
                                            onTap: () {
                                              if (snapshot.data?.groupId !=
                                                  null) {
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
                                                Text(snapshot
                                                        .data?.group?.name ??
                                                    ''),
                                              ],
                                            ),
                                          ),
                                        if (snapshot.data?.corporateId != null)
                                          ShrinkingButton(
                                            onTap: () {
                                              context.push(
                                                  '/prayers/corporate/${snapshot.data!.corporateId!}');
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
                                                Text(snapshot.data?.corporate
                                                        ?.title ??
                                                    ''),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    UserChip(
                                      uid: snapshot.data?.userId,
                                      name: snapshot.data?.user?.name,
                                      profile: snapshot.data?.user?.profile,
                                      anon: snapshot.data?.anon ?? false,
                                    ),
                                  ],
                                ),
                              ),
                              if (snapshot.data?.userId ==
                                  FirebaseAuth.instance.currentUser?.uid)
                                PullDownButton(
                                    itemBuilder: (context) => [
                                          PullDownMenuItem(
                                            onTap: () {
                                              context
                                                  .read<PrayerRepository>()
                                                  .deletePrayer(
                                                      prayerId: prayerId);
                                              context.pop('deleted');
                                            },
                                            title: "Delete",
                                            icon: FontAwesomeIcons.trash,
                                            isDestructive: true,
                                          ),
                                        ],
                                    buttonBuilder: (context, showMenu) {
                                      return NavigateIconButton(
                                        onPressed: showMenu,
                                        icon: FontAwesomeIcons
                                            .solidEllipsisVertical,
                                      );
                                    })
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data?.value ?? '',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (snapshot.data?.media != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.media!,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: PraysScreen(
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
                      loading: snapshot.data == null ||
                          snapshot.connectionState == ConnectionState.waiting,
                      prayerId: prayerId,
                      hasPrayed: hasPrayed.value,
                      onPray: onPray,
                      value: praysCount.value,
                    ),
                  ),
                  const SizedBox(width: 20),
                  PrayButton(
                    loading: snapshot.data == null ||
                        snapshot.connectionState == ConnectionState.waiting,
                    prayerId: prayerId,
                    hasPrayed: hasPrayed.value,
                    value: praysCount.value,
                    silent: true,
                    onPray: onPray,
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

class PraysScreen extends HookWidget {
  const PraysScreen({
    super.key,
    required this.prayerId,
    required this.pagingController,
  });

  final String prayerId;
  final PagingController<int?, PrayerPray> pagingController;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final requestPage = useCallback((int? cursor) {
      context
          .read<PrayerRepository>()
          .fetchPrayerPrays(
            prayerId: prayerId,
            cursor: cursor,
          )
          .then((data) {
        final d = data['prays'] as List<PrayerPray>;
        final cursor = data['cursor'];
        if (cursor == null) {
          pagingController.appendLastPage(d);
        } else {
          pagingController.appendPage(d, cursor);
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
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, item, index) => ContextMenuWidget(
          menuProvider: (_) => Menu(
            children: [
              MenuAction(
                callback: () {
                  context.push(Uri(
                      path: '/users',
                      queryParameters: {'uid': item.user.uid}).toString());
                },
                title: item.user.username,
              ),
              MenuAction(
                callback: () async {
                  await context
                      .read<PrayerRepository>()
                      .deletePrayerPray(prayerId: prayerId, prayId: item.id)
                      .then((value) {
                    if (value) {
                      pagingController.value = PagingState(
                        nextPageKey: pagingController.value.nextPageKey,
                        itemList: [...(pagingController.value.itemList ?? [])]
                          ..removeAt(index),
                        error: pagingController.value.error,
                      );
                    } else {
                      GlobalSnackBar.show(context,
                          message: "Failed to delete a pray");
                    }
                  }).catchError((e) {
                    GlobalSnackBar.show(context,
                        message: "Failed to delete a pray");
                  });
                },
                title: 'Delete',
                image: MenuImage.icon(FontAwesomeIcons.trash),
                attributes: MenuActionAttributes(
                    destructive: true,
                    disabled: FirebaseAuth.instance.currentUser!.uid !=
                        item.user.uid),
              ),
            ],
          ),
          child: item.value == null
              ? PraySlimCard(pray: item)
              : PrayLargeCard(pray: item),
        ),
      ),
    );
  }
}
