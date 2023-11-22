import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/user_model.dart';
import 'package:prayer/presentation/screens/group/group_search_screen.dart';
import 'package:prayer/presentation/screens/users/users_screen.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/tab_bar.dart';

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = useState('');
    final queryController = useTextEditingController();
    final groupsPagingController =
        usePagingController<String?, String>(firstPageKey: null);
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
                  flexibleSpace: Container(
                    margin: EdgeInsets.fromLTRB(
                      20,
                      MediaQuery.of(context).padding.top,
                      20,
                      10,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchBar(
                            controller: queryController,
                            hintText: "Search...",
                            hintStyle: const MaterialStatePropertyAll(
                              TextStyle(color: MyTheme.disabled),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ShrinkingButton(
                          onTap: () async {
                            final didAdd = await context.push('/form/group');
                            if (didAdd == true) {
                              groupsPagingController.refresh();
                            }
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.userPlus,
                            color: MyTheme.onPrimary,
                            size: 20,
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
                    CustomTabBar(tabs: ['Groups', 'Users']),
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
