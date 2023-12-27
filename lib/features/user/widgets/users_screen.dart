import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/features/user/widgets/user_card.dart';
import 'package:prayer/repo/user_repository.dart';

class UsersScreen extends HookWidget {
  const UsersScreen({
    super.key,
    required this.pagingController,
    this.query = '',
    this.scrollController,
    this.hideOnEmptyQuery = true,
  });

  final ScrollController? scrollController;
  final PagingController<String?, PUser> pagingController;
  final String query;
  final bool hideOnEmptyQuery;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final fetchPage = useCallback((String? cursor) async {
      if (hideOnEmptyQuery && query == '') {
        return pagingController.appendLastPage([]);
      }
      try {
        final data = await GetIt.I<UserRepository>().fetchUsers(
          query: query,
          cursor: cursor,
        );
        if (data.cursor != null) {
          pagingController.appendPage(data.items!, data.cursor);
        } else {
          pagingController.appendLastPage(data.items!);
        }
      } catch (e, st) {
        talker.handle(e, st, '[UsersScreen] Failed to search users');
        pagingController.error = e;
      }
    }, [query]);

    useEffect(() {
      pagingController.refresh();

      return () => null;
    }, [query]);

    useEffect(() {
      pagingController.addPageRequestListener(fetchPage);

      return () => pagingController.removePageRequestListener(fetchPage);
    }, [fetchPage]);

    if (hideOnEmptyQuery && query == '') {
      return const SizedBox();
    }

    return PagedListView(
      pagingController: pagingController,
      scrollController: scrollController,
      builderDelegate: PagedChildBuilderDelegate<PUser>(
        itemBuilder: (context, item, index) => UserCard(
          uid: item.uid,
          profile: item.profile,
          name: item.name,
          username: item.username,
        ),
      ),
    );
  }
}
