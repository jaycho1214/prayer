import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/prayer/widgets/prayer_card.dart';
import 'package:prayer/features/prayer/providers/deleted_prayer_provider.dart';
import 'package:prayer/repo/response_types.dart';

class PrayersScreen<CursorType> extends HookConsumerWidget {
  const PrayersScreen({
    super.key,
    required this.fetchFn,
    required this.pagingController,
    this.scrollController,
    this.onTap,
    this.physics,
    this.sliver = false,
    this.noItemsFoundIndicatorBuilder,
  });

  final Future<PaginationResponse<String, CursorType?>> Function(
      CursorType? cursor)? fetchFn;
  final ScrollController? scrollController;
  final PagingController<CursorType?, String> pagingController;
  final void Function(String)? onTap;
  final ScrollPhysics? physics;
  final bool sliver;
  final Widget Function(BuildContext)? noItemsFoundIndicatorBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    ref.listen(deletedPrayerNotifierProvider, (previous, next) {
      pagingController.value = PagingState(
        nextPageKey: pagingController.value.nextPageKey,
        itemList: [...pagingController.value.itemList ?? []]
          ..removeWhere((element) => next.indexOf(element) != -1),
        error: pagingController.value.error,
      );
    });

    final requestPage = useCallback((CursorType? cursor) {
      if (fetchFn == null) {
        return;
      }
      fetchFn!(cursor).then((data) {
        if (data.cursor == null) {
          pagingController.appendLastPage(data.items ?? []);
        } else {
          pagingController.appendPage(data.items ?? [], data.cursor);
        }
      }).catchError((e, st) {
        talker.handle(e, st,
            "[PrayersScreen] Failed to fetch next page of group prayers");
        pagingController.error = e;
      });
    }, [pagingController]);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () => pagingController.removePageRequestListener(requestPage);
    }, [pagingController]);

    if (sliver) {
      return PagedSliverList<CursorType?, String>.separated(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
          animateTransitions: true,
          itemBuilder: (context, item, index) => Padding(
            padding: EdgeInsets.only(
                bottom:
                    pagingController.itemList?.length == index + 1 ? 100 : 0),
            child: PrayerCard(
              prayerId: item,
              onTap: () => onTap?.call(item),
            ),
          ),
        ),
        separatorBuilder: (context, index) =>
            const Divider(color: MyTheme.disabled),
      );
    }

    return PagedListView<CursorType?, String>.separated(
      physics: physics,
      cacheExtent: 5000,
      scrollController: scrollController,
      pagingController: pagingController,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 150),
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        itemBuilder: (context, item, index) => PrayerCard(
          prayerId: item,
          onTap: () => onTap?.call(item),
        ),
      ),
      separatorBuilder: (context, index) =>
          const Divider(color: MyTheme.disabled),
    );
  }
}
