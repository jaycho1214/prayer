import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/repo/group_repository.dart';

class MiniMyGroupList extends HookWidget {
  const MiniMyGroupList({
    super.key,
    required this.pagingController,
  });

  final PagingController<String?, Group> pagingController;

  @override
  Widget build(BuildContext context) {
    final visible = useState(true);

    final requestPage = useCallback((String? cursor) async {
      try {
        final data = await GetIt.I<GroupRepository>().fetchGroupsByUser(
            uid: FirebaseAuth.instance.currentUser!.uid, cursor: cursor);
        final newGroups = data.items ?? [];
        final newCursor = data.cursor;
        if (newCursor == null) {
          pagingController.appendLastPage(newGroups);
        } else {
          pagingController.appendPage(newGroups, newCursor);
        }
      } catch (e, st) {
        talker.handle(e, st, "[GroupsScreen] Failed to fetch groups");
        pagingController.error = e;
      }
    }, []);

    useEffect(() {
      pagingController.addPageRequestListener(requestPage);
      pagingController.addListener(() {
        visible.value = (pagingController.value.itemList?.length ?? 0) > 0;
      });
      return () {
        pagingController.removePageRequestListener(requestPage);
      };
    }, []);

    return Visibility(
      visible: visible.value,
      maintainState: true,
      child: Container(
        width: double.infinity,
        height: 108,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: MyTheme.disabled),
          ),
        ),
        child: PagedListView(
          scrollDirection: Axis.horizontal,
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<Group>(
            firstPageProgressIndicatorBuilder: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
            itemBuilder: (context, group, index) => ShrinkingButton(
              onTap: () => context.push('/groups/${group.id}'),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyTheme.disabled, width: 1.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (group.banner != null)
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: group.banner!,
                          width: 120,
                          height: 60,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Text(
                        group.name,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
