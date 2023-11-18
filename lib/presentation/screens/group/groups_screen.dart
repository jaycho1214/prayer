import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/presentation/widgets/group_card.dart';

class GroupsScreen extends HookWidget {
  const GroupsScreen({
    super.key,
    required this.pagingController,
    this.fetchFn,
    this.scrollController,
    this.onTap,
    this.physics,
  });

  final Future<Map<dynamic, dynamic>> Function(String? cursor)? fetchFn;
  final ScrollController? scrollController;
  final PagingController<String?, String> pagingController;
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
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      return () {
        pagingController.removePageRequestListener(requestPage);
      };
    }, []);

    return PagedListView<String?, String>(
      scrollController: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: physics,
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => GroupCard(
          groupId: item,
          onTap: onTap != null ? () => onTap?.call(item) : null,
        ),
      ),
    );
  }
}
