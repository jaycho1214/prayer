import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/screens/empty_prayers_screen.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/home/widgets/mini_my_group_list.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/prayer/widgets/prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/repo/prayer_repository.dart';

class GroupPrayersScreen extends HookWidget {
  const GroupPrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final query = useState('');
    final queryController = useTextEditingController();
    final pagingController =
        usePagingController<String?, String>(firstPageKey: null);
    final groupPagingController =
        usePagingController<String?, Group>(firstPageKey: null);

    useEffect(() {
      void listener() {
        query.value = queryController.text;
      }

      queryController.addListener(listener);
      return () {
        queryController.removeListener(listener);
      };
    }, []);

    return KeyboardDismissOnTap(
      child: RefreshIndicator(
        notificationPredicate: (notification) => notification.depth == 0,
        onRefresh: () async {
          pagingController.refresh();
          groupPagingController.refresh();
        },
        child: CustomScrollView(
          cacheExtent: 5000,
          slivers: [
            SliverAppBar(
              toolbarHeight: 40,
              floating: true,
              pinned: false,
              snap: true,
              flexibleSpace: Container(
                height: 40,
                margin: EdgeInsets.fromLTRB(
                    10, MediaQuery.of(context).padding.top, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Platform.isIOS
                          ? Alignment.center
                          : Alignment.centerLeft,
                      child: Text(
                        S.of(context).group,
                        style: platformThemeData(
                          context,
                          material: (ThemeData data) =>
                              data.textTheme.headlineSmall,
                          cupertino: (data) => data.textTheme.navTitleTextStyle,
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ShrinkingButton(
                            onTap: () {
                              context.push('/search');
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ShrinkingButton(
                            onTap: () async {
                              context.push('/form/group');
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 32,
                                  height: 20,
                                  child: const FaIcon(
                                    FontAwesomeIcons.userGroupSimple,
                                    size: 20,
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 0,
                                  child: Container(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: const FaIcon(
                                      FontAwesomeIcons.solidPlus,
                                      size: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: MiniMyGroupList(
                pagingController: groupPagingController,
              ),
            ),
            PrayersScreen(
              sliver: true,
              fetchFn: (cursor) => GetIt.I<PrayerRepository>()
                  .fetchGroupPrayersFromUser(cursor: cursor),
              pagingController: pagingController,
              noItemsFoundIndicatorBuilder: (p0) => EmptyPrayersScreen(
                title: S.of(context).prayWithOthers,
                description: S.of(context).emptyGroupDescription,
                buttonText: S.of(context).createGroup,
                onTap: () => context.push('/form/group'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
