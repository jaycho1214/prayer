import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/presentation/widgets/user/user_card.dart';
import 'package:prayer/repo/user_repository.dart';

class UsersScreen extends HookWidget {
  const UsersScreen({
    super.key,
    required this.pagingController,
    this.query = '',
  });

  final PagingController<String?, dynamic> pagingController;
  final String query;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final fetchPage = useCallback((String? cursor) async {
      try {
        final data = await context.read<UserRepository>().fetchUsers(
              query: query,
              cursor: cursor,
            );
        if (data['cursor'] != null) {
          pagingController.appendPage(data['data'], data['cursor']);
        } else {
          pagingController.appendLastPage(data['data']);
        }
      } catch (error) {
        talker.error('Error while searching users: $error');
        pagingController.error = error;
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
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        itemBuilder: (context, item, index) => UserCard(
          uid: item['uid']!,
          profile: item['profile'],
          name: item['name']!,
          username: item['username']!,
        ),
      ),
    );
  }
}
