import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/presentation/widgets/group_card.dart';
import 'package:prayer/repo/response_types.dart';

class GroupsScreen extends HookWidget {
  const GroupsScreen({
    super.key,
    required this.pagingController,
    this.fetchFn,
    this.scrollController,
    this.onTap,
    this.physics,
  });

  final Future<PaginationResponse<Group, String?>> Function(String? cursor)?
      fetchFn;
  final ScrollController? scrollController;
  final PagingController<String?, Group> pagingController;
  final ScrollPhysics? physics;
  final void Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final requestPage = useCallback((String? cursor) {
      if (fetchFn == null) {
        return;
      }
      fetchFn!(cursor).then((data) {
        final groups = data.items ?? [];
        final cursor = data.cursor;
        if (cursor == null) {
          pagingController.appendLastPage(groups);
        } else {
          pagingController.appendPage(groups, cursor);
        }
      }).catchError((e) {
        talker.error("Error on fetching next page of groups: $e");
        pagingController.error = e;
      });
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () {
        pagingController.removePageRequestListener(requestPage);
      };
    }, []);

    return PagedListView<String?, Group>(
      scrollController: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: physics,
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, item, index) => GroupCard(
          group: item,
          onTap: onTap != null ? () => onTap?.call(item.id) : null,
        ),
      ),
    );
  }
}
