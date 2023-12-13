import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/hook/paging_controller_hook.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/presentation/widgets/button/navigate_button.dart';
import 'package:prayer/presentation/widgets/notification_bar.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/presentation/widgets/user/user_card.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class InviteUsersPickerProvider extends ChangeNotifier {
  List<PUser> users = [];
  bool loading = false;

  void add(PUser user) {
    users.add(user);
    notifyListeners();
  }

  void remove(PUser user) {
    users.removeWhere((u) => u.uid == user.uid);
    notifyListeners();
  }

  void update(List<PUser> newUsers) {
    users = newUsers;
    notifyListeners();
  }

  void reset() {
    users.clear();
    notifyListeners();
  }

  void inviteUser({
    required String groupId,
    void Function()? onThen,
    void Function()? onError,
  }) {
    if (users.length == 0) {
      onError?.call();
    }
    loading = true;
    notifyListeners();
    GetIt.I<GroupRepository>()
        .inviteUserToGroup(
          groupId: groupId,
          userIds: users.map((e) => e.uid).toList(),
        )
        .then((_) => onThen?.call())
        .onError((err, __) {
      talker.error("Error on inviting user", err);
      onError?.call();
    }).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}

final inviteUsersPickerProvider =
    ChangeNotifierProvider((ref) => InviteUsersPickerProvider());

class InviteUsersPicker extends HookConsumerWidget {
  const InviteUsersPicker({
    super.key,
    required this.groupId,
    required this.builder,
    this.onChange,
  });

  final String groupId;
  final Widget Function(BuildContext context, Future<bool?> Function() onTap)
      builder;
  final void Function(String uid)? onChange;

  Widget buildFabButton(
    BuildContext context, {
    bool loading = false,
    void Function()? onTap,
    required IconData icon,
  }) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.fromLTRB(
        20.0,
        0.0,
        20.0,
        MediaQuery.of(context).padding.bottom,
      ),
      child: ShrinkingButton(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          width: 60,
          height: 60,
          child: Center(
              child: loading
                  ? CircularProgressIndicator.adaptive()
                  : FaIcon(
                      icon,
                      color: Colors.black,
                      size: 20,
                    )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = useValueNotifier(0);
    final query = useState('');
    final queryController = useTextEditingController();
    final pagingController =
        usePagingController<String?, PUser>(firstPageKey: null);

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
      final data = await GetIt.I<UserRepository>().fetchUsers(
        cursor: cursor,
        query: query.value,
        excludeGroupId: groupId,
      );
      if (data.error != null) {
        talker.error('Error while searching users: ${data.error}');
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
        (BuildContext context) => SliverWoltModalSheetPage(
              backgroundColor: Colors.black,
              hasSabGradient: false,
              hasTopBarLayer: true,
              leadingNavBarWidget: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                child: NavigateBackButton(),
              ),
              isTopBarLayerAlwaysVisible: true,
              stickyActionBar: Consumer(builder: (context, ref, _) {
                return buildFabButton(
                  context,
                  icon: FontAwesomeIcons.arrowRight,
                  onTap: () {
                    if (ref.read(inviteUsersPickerProvider).users.length == 0) {
                      GlobalSnackBar.show(context,
                          message: S.of(context).errorChooseUserToInvite);
                      return;
                    }
                    pageIndex.value += 1;
                  },
                );
              }),
              topBarTitle: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: SearchBar(
                  controller: queryController,
                  hintText: S.of(context).placeholderSearch,
                  backgroundColor:
                      const MaterialStatePropertyAll(MyTheme.primary),
                  hintStyle: const MaterialStatePropertyAll(
                    TextStyle(color: MyTheme.placeholderText),
                  ),
                ),
              ),
              forceMaxHeight: true,
              mainContentSlivers: [
                PagedSliverList<String?, PUser>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, index) => Padding(
                      padding: EdgeInsets.only(
                          bottom: index + 1 == pagingController.itemList?.length
                              ? 200
                              : 0),
                      child: Consumer(
                        builder: (context, ref, _) {
                          final checked = ref
                                  .watch(inviteUsersPickerProvider)
                                  .users
                                  .indexWhere(
                                      (element) => element.uid == item.uid) !=
                              -1;
                          return Row(
                            children: [
                              Expanded(
                                child: UserCard(
                                  uid: item.uid,
                                  name: item.name,
                                  username: item.username,
                                  profile: item.profile,
                                  onTap: () {
                                    if (checked) {
                                      ref
                                          .read(inviteUsersPickerProvider)
                                          .remove(item);
                                    } else {
                                      ref
                                          .read(inviteUsersPickerProvider)
                                          .add(item);
                                    }
                                  },
                                ),
                              ),
                              if (checked)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.check,
                                    size: 12,
                                    color: MyTheme.onPrimary,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
        []);

    final confirmPage = useCallback(
        (BuildContext context) => WoltModalSheetPage(
              backgroundColor: Colors.black,
              hasSabGradient: false,
              hasTopBarLayer: true,
              stickyActionBar: Consumer(
                builder: (context, ref, _) {
                  final loading = ref.watch(inviteUsersPickerProvider).loading;
                  return buildFabButton(
                    context,
                    loading: loading,
                    icon: FontAwesomeIcons.check,
                    onTap: () {
                      ref.read(inviteUsersPickerProvider).inviteUser(
                          groupId: groupId,
                          onThen: () {
                            context.pop(true);
                            NotificationSnackBar.show(context,
                                message: "Users have been invited");
                          },
                          onError: () {
                            GlobalSnackBar.show(context,
                                message: "Unknown Error Occured");
                          });
                    },
                  );
                },
              ),
              topBarTitle: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                child: Text(
                  S.of(context).sendInvitation,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                height: MediaQuery.of(context).size.height * 0.9,
                child: Consumer(
                  builder: (context, ref, child) {
                    final member = ref.watch(inviteUsersPickerProvider).users;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Text(
                                S.of(context).titleInvitePeople(member.length),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                S.of(context).titleInvitePeopleDescription,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: MyTheme.placeholderText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: member.length,
                            itemBuilder: (context, index) => UserCard(
                              uid: member[index].uid,
                              name: member[index].name,
                              username: member[index].username,
                              profile: member[index].profile,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
        []);

    final onTap = useCallback((BuildContext context) {
      pageIndex.value = 0;
      ref.watch(inviteUsersPickerProvider).reset();
      return WoltModalSheet.show<bool?>(
          pageIndexNotifier: pageIndex,
          modalBarrierColor: Colors.white.withOpacity(0.15),
          context: context,
          useSafeArea: false,
          modalTypeBuilder: (_) => WoltModalType.bottomSheet,
          minPageHeight: 0.9,
          maxPageHeight: 0.9,
          pageListBuilder: (modalSheetContext) => [
                usersPage(modalSheetContext),
                confirmPage(modalSheetContext),
              ],
          onModalDismissedWithBarrierTap: () {
            ref.read(inviteUsersPickerProvider).reset();
            pageIndex.value = 0;
            context.pop(null);
          },
          onModalDismissedWithDrag: () {
            ref.read(inviteUsersPickerProvider).reset();
            pageIndex.value = 0;
            context.pop(null);
          });
    }, [
      context,
    ]);

    return Builder(
      builder: (context) {
        return builder(context, () => onTap(context));
      },
    );
  }
}
