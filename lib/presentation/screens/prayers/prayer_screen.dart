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
import 'package:prayer/model/user_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/button/pray_button.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        usePagingController<String?, PUser>(firstPageKey: null);

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
            child: PrayButton(
              key: ObjectKey(snapshot.data?.praysCount),
              prayerId: prayerId,
              hasPrayed: snapshot.data?.hasPrayed != null,
              value: snapshot.data?.praysCount ?? 0,
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
  final PagingController<String?, PUser> pagingController;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final requestPage = useCallback((String? cursor) {
      context
          .read<PrayerRepository>()
          .fetchPrayerPrays(
            prayerId: prayerId,
            cursor: cursor,
          )
          .then((data) {
        final d = data['users'] as List<PUser>;
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

    return PagedListView<String?, PUser>(
      physics: const NeverScrollableScrollPhysics(),
      pagingController: pagingController,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => ShrinkingButton(
          onTap: () {
            context.push(Uri(path: '/users', queryParameters: {'uid': item.uid})
                .toString());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                UserProfileImage(
                  profile: item.profile,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${item.username} has prayed for you',
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  item.createdAt != null
                      ? Formatter.fromNow(item.createdAt!)
                      : '',
                  style: TextStyle(
                    color: MyTheme.outline,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
