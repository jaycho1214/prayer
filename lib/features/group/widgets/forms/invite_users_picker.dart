import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/features/common/widgets/buttons/navigate_button.dart';
import 'package:prayer/features/common/widgets/notification_bar.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/widgets/user_card.dart';
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
        .then((_) {
      talker.good('[InviteUserPicker] User Invited');
      onThen?.call();
    }).onError((e, st) {
      if (e != null) {
        talker.handle(
            e,
            st,
            generateLogMessage('[InviteUserPicker] Failed to invite user',
                data: {
                  'groupId': groupId,
                }));
      }
      onError?.call();
    }).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}

final inviteUsersPickerProvider =
    ChangeNotifierProvider((ref) => InviteUsersPickerProvider());

class InviteUsersPickerFAB extends StatelessWidget {
  const InviteUsersPickerFAB({
    super.key,
    required this.icon,
    this.loading = false,
    this.onTap,
  });

  final IconData icon;
  final bool loading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.fromLTRB(
        20.0,
        0.0,
        20.0,
        MediaQuery.of(context).padding.bottom + 10,
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
                  ),
          ),
        ),
      ),
    );
  }
}

class InviteUsersPicker extends ConsumerStatefulWidget {
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

  @override
  ConsumerState<InviteUsersPicker> createState() => _InviteUsersPickerState();
}

class _InviteUsersPickerState extends ConsumerState<InviteUsersPicker> {
  final pageIndex = ValueNotifier(0);
  final queryController = TextEditingController();
  final pagingController = PagingController<String?, PUser>(firstPageKey: null);

  String query = '';

  Future<void> fetchPage(String? cursor) async {
    try {
      if (queryController.text.trim() == '') {
        pagingController.value = PagingState(nextPageKey: null, itemList: []);
        return;
      }
      final data = await GetIt.I<UserRepository>().fetchUsers(
        cursor: cursor,
        query: query,
        excludeGroupId: widget.groupId,
      );
      if (data.cursor != null) {
        pagingController.appendPage(data.items!, data.cursor);
      } else {
        pagingController.appendLastPage(data.items!);
      }
    } catch (e, st) {
      talker.handle(e, st, '[InviteUserPicker] Failed to search users');
      pagingController.error = e;
    }
  }

  @override
  void initState() {
    super.initState();
    queryController.addListener(() {
      setState(() {
        query = queryController.text;
      });
      if (queryController.text.trim() == '') {
        pagingController.value = PagingState(nextPageKey: null, itemList: []);
      } else {
        pagingController.refresh();
      }
    });
    pagingController.addPageRequestListener(fetchPage);
  }

  @override
  void dispose() {
    pageIndex.dispose();
    pagingController.dispose();
    queryController.dispose();
    super.dispose();
  }

  SliverWoltModalSheetPage buildInvitingUsersSearchScreen(
      BuildContext context) {
    return SliverWoltModalSheetPage(
      backgroundColor: Colors.black,
      hasSabGradient: false,
      hasTopBarLayer: true,
      leadingNavBarWidget: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
        child: NavigateBackButton(),
      ),
      isTopBarLayerAlwaysVisible: true,
      stickyActionBar: Consumer(
        builder: (context, ref, _) => InviteUsersPickerFAB(
          icon: FontAwesomeIcons.arrowRight,
          onTap: () {
            if (ref.read(inviteUsersPickerProvider).users.length == 0) {
              GlobalSnackBar.show(context,
                  message: S.of(context).errorChooseUserToInvite);
              return;
            }
            pageIndex.value += 1;
          },
        ),
      ),
      topBarTitle: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: SearchBar(
          controller: queryController,
          hintText: S.of(context).placeholderSearch,
          backgroundColor: const MaterialStatePropertyAll(MyTheme.primary),
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
            noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
            itemBuilder: (context, item, index) => Padding(
              padding: EdgeInsets.only(
                  bottom:
                      index + 1 == pagingController.itemList?.length ? 200 : 0),
              child: Consumer(
                builder: (context, ref, _) {
                  final checked = ref
                          .watch(inviteUsersPickerProvider)
                          .users
                          .indexWhere((element) => element.uid == item.uid) !=
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
                              ref.read(inviteUsersPickerProvider).remove(item);
                            } else {
                              ref.read(inviteUsersPickerProvider).add(item);
                            }
                          },
                        ),
                      ),
                      if (checked)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }

  WoltModalSheetPage buildConfirmUsersInviteScreen(BuildContext context) {
    return WoltModalSheetPage(
      backgroundColor: Colors.black,
      hasSabGradient: false,
      hasTopBarLayer: true,
      stickyActionBar: Consumer(
        builder: (context, ref, _) {
          final loading = ref.watch(inviteUsersPickerProvider).loading;
          return InviteUsersPickerFAB(
            loading: loading,
            icon: FontAwesomeIcons.check,
            onTap: () {
              ref.read(inviteUsersPickerProvider).inviteUser(
                    groupId: widget.groupId,
                    onThen: () {
                      context.pop(true);
                      NotificationSnackBar.show(context,
                          message: "Users have been invited");
                    },
                    onError: () {
                      GlobalSnackBar.show(context,
                          message: "Unknown Error Occured");
                    },
                  );
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
    );
  }

  Future<bool?> onTap(BuildContext context) {
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
              buildInvitingUsersSearchScreen(modalSheetContext),
              buildConfirmUsersInviteScreen(modalSheetContext),
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
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return widget.builder(context, () => onTap(context));
      },
    );
  }
}
