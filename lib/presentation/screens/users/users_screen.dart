import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/user_model.dart';
import 'package:prayer/presentation/widgets/user/user_card.dart';
import 'package:prayer/repo/user_repository.dart';

class UsersScreen extends HookWidget {
  const UsersScreen({
    super.key,
    required this.pagingController,
    this.query = '',
  });

  final PagingController<String?, PUser> pagingController;
  final String query;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final fetchPage = useCallback((String? cursor) async {
      final data = await GetIt.I<UserRepository>().fetchUsers(
        query: query,
        cursor: cursor,
      );
      if (data.error != null) {
        talker.error('Error while searching users: ${data.error}');
        pagingController.error = data.error;
      } else if (data.cursor != null) {
        pagingController.appendPage(data.items!, data.cursor);
      } else {
        pagingController.appendLastPage(data.items!);
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

    return PagedListView(
      pagingController: pagingController,
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
