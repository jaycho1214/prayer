import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/group_member_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/presentation/widgets/user/user_card.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MemberPickerProvider extends ChangeNotifier {
  GroupMember? member;
  bool loading = false;

  void update(GroupMember? newMember) {
    member = newMember;
    notifyListeners();
  }

  void promoteUser(
      {required String groupId,
      void Function(String)? onThen,
      void Function()? onError}) {
    if (member == null) {
      onError?.call();
    }
    loading = true;
    notifyListeners();
    GetIt.I<GroupRepository>()
        .promoteMember(
      groupId: groupId,
      userId: member!.uid,
      value: true,
    )
        .then((value) {
      onThen?.call(member!.uid);
    }).catchError((e) {
      talker.error("Failed on promoting a user", e);
      onError?.call();
    }).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}

final memberPickerProvider =
    ChangeNotifierProvider((ref) => MemberPickerProvider());

class MemberPicker extends HookConsumerWidget {
  const MemberPicker({
    super.key,
    required this.groupId,
    required this.builder,
  });

  final String groupId;
  final Widget Function(BuildContext context, Future<String?> Function() onTap)
      builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = useValueNotifier(0);
    final query = useState('');
    final queryController = useTextEditingController();
    final pagingController =
        usePagingController<String?, GroupMember>(firstPageKey: null);

    useEffect(() {
      void fn() {
        query.value = queryController.text;
      }

      queryController.addListener(fn);
      return () => queryController.removeListener(fn);
    }, [queryController]);

    useEffect(() {
      pagingController.refresh();
      return () => null;
    }, [query.value]);

    final fetchPage = useCallback((String? cursor) async {
      final data = await GetIt.I<GroupRepository>().fetchGroupMembers(
        groupId: groupId,
        cursor: cursor,
        query: query.value,
        type: 'members',
      );
      if (data.error != null) {
        talker.error('Error while fetching group members: ${data.error}');
        pagingController.error = data.error;
      } else if (data.cursor != null) {
        pagingController.appendPage(data.items!, data.cursor);
      } else {
        pagingController.appendLastPage(data.items!);
      }
    }, [groupId, query.value]);

    useEffect(() {
      pagingController.addPageRequestListener(fetchPage);

      return () => pagingController.removePageRequestListener(fetchPage);
    }, [fetchPage]);

    final usersPage = useCallback(
        (BuildContext context) => WoltModalSheetPage.withSingleChild(
              backgroundColor: Colors.black,
              hasSabGradient: false,
              hasTopBarLayer: true,
              leadingNavBarWidget: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                child: NavigateBackButton(),
              ),
              isTopBarLayerAlwaysVisible: true,
              topBarTitle: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: SearchBar(
                  controller: queryController,
                  hintText: "Search...",
                  backgroundColor:
                      const MaterialStatePropertyAll(MyTheme.primary),
                  hintStyle: const MaterialStatePropertyAll(
                    TextStyle(color: MyTheme.placeholderText),
                  ),
                ),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: PagedListView<String?, GroupMember>(
                  padding: const EdgeInsets.all(0),
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) => UserCard(
                      uid: item.uid,
                      name: item.name,
                      username: item.username,
                      profile: item.profile,
                      onTap: () {
                        ref.read(memberPickerProvider).update(item);
                        pageIndex.value += 1;
                      },
                    ),
                  ),
                ),
              ),
            ),
        []);

    final confirmPage = useCallback(
        (BuildContext) => WoltModalSheetPage.withSingleChild(
              backgroundColor: Colors.black,
              hasSabGradient: false,
              hasTopBarLayer: true,
              leadingNavBarWidget: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                child: NavigateBackButton(
                  onPressed: () {
                    pageIndex.value -= 1;
                  },
                ),
              ),
              isTopBarLayerAlwaysVisible: true,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Consumer(
                  builder: (context, ref, child) {
                    final member = ref.watch(memberPickerProvider).member;
                    return Column(
                      children: [
                        UserProfileImage(
                          profile: member?.profile,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Promote ${member?.name}?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "1. Moderators have the ability to invite others or accept join requests."),
                              const SizedBox(height: 10),
                              Text("2. Moderators can post corporate prayers."),
                              const SizedBox(height: 10),
                              Text(
                                  "3. Moderators can set notifications for prayer times."),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ShrinkingButton(
                                  onTap: () => context.pop(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    width: 60,
                                    height: 60,
                                    child: Icon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ShrinkingButton(
                                onTap: () {
                                  ref.read(memberPickerProvider).promoteUser(
                                      groupId: groupId,
                                      onThen: (String uid) {
                                        ref
                                            .read(memberPickerProvider)
                                            .update(null);
                                        pageIndex.value = 0;
                                        context.pop(uid);
                                      },
                                      onError: () {
                                        GlobalSnackBar.show(context,
                                            message:
                                                "Failed to promote the user");
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.userPlus,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
        []);

    final onTap = useCallback(
        (BuildContext context) => WoltModalSheet.show<String?>(
            pageIndexNotifier: pageIndex,
            modalBarrierColor: Colors.white.withOpacity(0.15),
            context: context,
            useSafeArea: false,
            modalTypeBuilder: (_) => WoltModalType.bottomSheet,
            minPageHeight: 0.5,
            maxPageHeight: 0.9,
            pageListBuilder: (modalSheetContext) => [
                  usersPage(modalSheetContext),
                  confirmPage(modalSheetContext),
                ],
            onModalDismissedWithBarrierTap: () {
              ref.read(memberPickerProvider).update(null);
              pageIndex.value = 0;
              context.pop(null);
            },
            onModalDismissedWithDrag: () {
              ref.read(memberPickerProvider).update(null);
              pageIndex.value = 0;
              context.pop(null);
            }),
        [
          context,
        ]);

    return Builder(
      builder: (context) {
        return builder(context, () => onTap(context));
      },
    );
  }
}
