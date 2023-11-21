import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/presentation/widgets/group_card.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupSearchScreen extends HookWidget {
  const GroupSearchScreen({
    super.key,
    this.query,
    required this.pagingController,
    this.scrollController,
    this.onTap,
    this.uid,
  });

  final PagingController<String?, String> pagingController;
  final ScrollController? scrollController;
  final String? query;
  final String? uid;
  final void Function(String)? onTap;

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

    return PagedListView<String?, String>(
      scrollController: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        animateTransitions: true,
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GroupCard(
            groupId: item,
            onTap: onTap != null ? () => onTap?.call(item) : null,
          ),
        ),
      ),
    );
  }
}
