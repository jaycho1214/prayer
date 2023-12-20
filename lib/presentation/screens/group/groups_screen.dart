import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/presentation/widgets/group/group_card.dart';
import 'package:prayer/repo/response_types.dart';

class GroupsScreen<CursorType> extends HookWidget {
  const GroupsScreen({
    super.key,
    required this.pagingController,
    this.fetchFn,
    this.scrollController,
    this.onTap,
    this.physics,
    this.sliver = false,
  });

  final Future<PaginationResponse<Group, CursorType?>> Function(dynamic cursor)?
      fetchFn;
  final ScrollController? scrollController;
  final PagingController<CursorType, Group> pagingController;
  final ScrollPhysics? physics;
  final void Function(String)? onTap;
  final bool sliver;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final requestPage = useCallback((CursorType? cursor) {
      if (fetchFn == null) {
        return;
      }
      fetchFn!(cursor).then((data) {
        final newGroups = data.items ?? [];
        final newCursor = data.cursor;
        if (newCursor == null) {
          pagingController.appendLastPage(newGroups);
        } else {
          pagingController.appendPage(newGroups, newCursor);
        }
      }).catchError((e, st) {
        talker.handle(e, st, "[GroupsScreen] Failed to fetch groups");
        pagingController.error = e;
      });
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () {
        pagingController.removePageRequestListener(requestPage);
      };
    }, []);

    if (sliver) {
      return PagedSliverList<CursorType, Group>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          animateTransitions: true,
          itemBuilder: (context, item, index) => Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: GroupCard(
              group: item,
              onTap: onTap != null ? () => onTap?.call(item.id) : null,
            ),
          ),
        ),
      );
    }

    return PagedListView<CursorType, Group>(
      scrollController: scrollController,
      padding: const EdgeInsets.only(bottom: 10),
      physics: physics,
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: GroupCard(
            group: item,
            onTap: onTap != null ? () => onTap?.call(item.id) : null,
          ),
        ),
      ),
    );
  }
}
