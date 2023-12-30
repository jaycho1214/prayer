import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/features/group/widgets/group_search_screen.dart';
import 'package:prayer/features/user/widgets/users_screen.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/tab_bar.dart';

enum SearchScreenInitialPage { group, user }

class SearchScreen extends HookWidget {
  const SearchScreen({
    super.key,
    this.initialPage = SearchScreenInitialPage.group,
  });

  final SearchScreenInitialPage initialPage;

  @override
  Widget build(BuildContext context) {
    final query = useState('');
    final queryController = useTextEditingController();
    final groupsPagingController =
        usePagingController<String?, Group>(firstPageKey: null);
    final usersPagingController =
        usePagingController<String?, PUser>(firstPageKey: null);

    useEffect(() {
      void listener() {
        query.value = queryController.text;
      }

      queryController.addListener(listener);
      return () {
        queryController.removeListener(listener);
      };
    }, []);

    return DefaultTabController(
      initialIndex: initialPage == SearchScreenInitialPage.group ? 0 : 1,
      length: 2,
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: RefreshIndicator(
              notificationPredicate: (notification) => notification.depth == 1,
              onRefresh: () async {
                if (DefaultTabController.of(context).index == 0) {
                  groupsPagingController.refresh();
                } else {
                  usersPagingController.refresh();
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    margin: EdgeInsets.fromLTRB(
                      10,
                      MediaQuery.of(context).padding.top,
                      20,
                      10,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        NavigateBackButton(),
                        const SizedBox(width: 0),
                        Expanded(
                          child: SearchBar(
                            controller: queryController,
                            hintText: S.of(context).placeholderSearch,
                            hintStyle: const MaterialStatePropertyAll(
                              TextStyle(color: MyTheme.placeholderText),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: MyTheme.surface,
                ),
                backgroundColor: MyTheme.surface,
                body: Column(
                  children: [
                    CustomTabBar(
                        tabs: [S.of(context).groups, S.of(context).users]),
                    Expanded(
                      child: TabBarView(
                        children: [
                          GroupSearchScreen(
                            pagingController: groupsPagingController,
                            query: query.value,
                          ),
                          UsersScreen(
                            pagingController: usersPagingController,
                            query: query.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
