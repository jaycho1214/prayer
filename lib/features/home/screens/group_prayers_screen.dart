import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/features/prayer/widgets/prayers_screen.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
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

    useEffect(() {
      void listener() {
        query.value = queryController.text;
      }

      queryController.addListener(listener);
      return () {
        queryController.removeListener(listener);
      };
    }, []);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: RefreshIndicator(
        notificationPredicate: (notification) => notification.depth == 0,
        onRefresh: () async {
          pagingController.refresh();
        },
        child: CustomScrollView(
          cacheExtent: 5000,
          slivers: [
            SliverAppBar(
              toolbarHeight: 40,
              backgroundColor: MyTheme.surface,
              surfaceTintColor: MyTheme.surface,
              foregroundColor: MyTheme.surface,
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
                          cupertino: (data) => data.textTheme.navTitleTextStyle
                              .copyWith(fontWeight: FontWeight.bold),
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
                              color: MyTheme.onPrimary,
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
                                    color: MyTheme.onPrimary,
                                    size: 20,
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 0,
                                  child: Container(
                                    color: MyTheme.surface,
                                    child: const FaIcon(
                                      FontAwesomeIcons.solidPlus,
                                      color: MyTheme.onPrimary,
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
            PrayersScreen(
              sliver: true,
              fetchFn: (cursor) => GetIt.I<PrayerRepository>()
                  .fetchGroupPrayersFromUser(cursor: cursor),
              pagingController: pagingController,
              noItemsFoundIndicatorBuilder: (p0) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).prayWithOthers,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      S.of(context).emptyGroupDescription,
                      style: TextStyle(
                        fontSize: 15,
                        color: MyTheme.placeholderText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PrimaryTextButton(
                      text: S.of(context).searchGroup,
                      onTap: () => context.push('/search'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
