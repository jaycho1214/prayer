import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
      context
          .read<PrayerRepository>()
          .fetchGroupCoporatePrayers(
            groupId: groupId,
            cursor: cursor,
          )
          .then((data) {
        final groups = List<String>.from(data['data']);
        final cursor = data['cursor'];
        if (cursor == null) {
          pagingController.appendLastPage(groups);
        } else {
          pagingController.appendPage(groups, cursor);
        }
      }).catchError((e) {
        talker.error("Error on fetching next page of groups: $e");
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
