import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/prayer_card.dart';

class PrayersScreen extends HookWidget {
  const PrayersScreen({
    super.key,
    required this.fetchFn,
    required this.pagingController,
    this.scrollController,
    this.onTap,
    this.physics,
  });

  final Future<Map<dynamic, dynamic>> Function(String? cursor)? fetchFn;
  final ScrollController? scrollController;
  final PagingController<String?, String> pagingController;
  final void Function(String)? onTap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final requestPage = useCallback((String? cursor) {
      if (fetchFn == null) {
        return;
      }
      fetchFn!(cursor).then((data) {
        final d = List<String>.from(data['data']);
        final cursor = data['cursor'];
        if (cursor == null) {
          pagingController.appendLastPage(d);
        } else {
          pagingController.appendPage(d, cursor);
        }
      }).catchError((e) {
        talker.error("Error on fetching next page of group prayers: $e");
        pagingController.error = e;
      });
    }, [pagingController]);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () => pagingController.removePageRequestListener(requestPage);
    }, [pagingController]);

    return PagedListView<String?, String>.separated(
      physics: physics,
      cacheExtent: 5000,
      scrollController: scrollController,
      pagingController: pagingController,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 150),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => PrayerCard(
          key: ObjectKey(item),
          prayerId: item,
          onTap: () => onTap?.call(item),
        ),
      ),
      separatorBuilder: (context, index) =>
          const Divider(color: MyTheme.disabled),
    );
  }
}
