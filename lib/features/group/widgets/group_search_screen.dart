import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/group/widgets/group_card.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupSearchScreen extends HookWidget {
  const GroupSearchScreen({
    super.key,
    this.query,
    required this.pagingController,
    this.scrollController,
    this.onTap,
    this.uid,
    this.noItemsFoundIndicatorBuilder,
  });

  final PagingController<String?, Group> pagingController;
  final ScrollController? scrollController;
  final String? query;
  final String? uid;
  final void Function(String)? onTap;
  final Widget Function(BuildContext)? noItemsFoundIndicatorBuilder;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final requestPage = useCallback((String? cursor) {
      GetIt.I<GroupRepository>()
          .fetchGroups(
        query: query,
        cursor: cursor,
        userId: uid,
      )
          .then((data) {
        final newCursor = data.cursor;
        if (newCursor == null) {
          pagingController.appendLastPage(data.items!);
        } else {
          pagingController.appendPage(data.items!, newCursor);
        }
      }).catchError((e) {
        talker.error("Error on fetching next page of groups: $e");
        pagingController.error = e;
      });
    }, [query, uid]);

    useEffect(() {
      pagingController.refresh();
      return () => null;
    }, [query]);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () {
        pagingController.removePageRequestListener(requestPage);
      };
    }, []);

    return PagedListView<String?, Group>(
      scrollController: scrollController,
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GroupCard(
            group: item,
            onTap: onTap != null ? () => onTap?.call(item.id) : null,
          ),
        ),
      ),
    );
  }
}
