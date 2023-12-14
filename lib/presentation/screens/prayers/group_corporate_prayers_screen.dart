import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/corporate_prayer_card.dart';
import 'package:prayer/repo/prayer_repository.dart';

class GroupCorporatePrayersScreen extends HookWidget {
  const GroupCorporatePrayersScreen({
    super.key,
    required this.groupId,
    required this.pagingController,
    this.scrollController,
    this.onTap,
    this.physics,
  });

  final ScrollController? scrollController;
  final PagingController<String?, String> pagingController;
  final String groupId;
  final void Function(String)? onTap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final requestPage = useCallback((String? cursor) {
      GetIt.I<PrayerRepository>()
          .fetchGroupCoporatePrayers(
        groupId: groupId,
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
            "[CorporatePrayer] Failed to fetch next page of corporate prayers: (groupId: $groupId, cursor: $cursor)");
        pagingController.error = e;
      });
    }, [pagingController]);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () => pagingController.removePageRequestListener(requestPage);
    }, [pagingController]);

    return PagedListView<String?, String>.separated(
      physics: physics,
      scrollController: scrollController,
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => CorporatePrayerCard(
          prayerId: item,
          onTap: onTap == null ? null : () => onTap!.call(item),
        ),
      ),
      separatorBuilder: (context, index) =>
          const Divider(color: MyTheme.disabled),
    );
  }
}
