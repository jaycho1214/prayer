import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/common/sheets/confirm_menu_form.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/group/models/group_member/group_member_model.dart';
import 'package:prayer/features/common/sheets/confirm_slim_menu_form.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:pull_down_button/pull_down_button.dart';

enum GroupMemberCardActionType {
  accept,
  revoke,
  kick,
  ban,
  removeMod,
  promote,
  unban
}

class GroupMemberCard extends HookConsumerWidget {
  const GroupMemberCard({
    super.key,
    required this.groupId,
    required this.member,
    this.onDone,
    this.showAccept = false,
    this.showUndoInvite = false,
    this.showKick = false,
    this.showBan = false,
    this.showUnban = false,
    this.showRemoveMod = false,
    this.showPromote = false,
  });

  final String groupId;
  final GroupMember member;
  final bool showAccept;
  final bool showUndoInvite;
  final bool showKick;
  final bool showBan;
  final bool showUnban;
  final bool showRemoveMod;
  final bool showPromote;
  final void Function(GroupMemberCardActionType)? onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final group = ref.watch(GroupNotifierProvider(groupId)).value;

    final handleAccept = useCallback(() async {
      loading.value = true;
      final result = await ConfirmSlimMenuForm.show(
        context,
        title: t.group.alert.acceptMember(username: member.username),
        description: t.alert.actionIrreversible,
        icon: FontAwesomeIcons.check,
      );
      if (result == true) {
        GetIt.I<GroupRepository>()
            .acceptMember(groupId: groupId, userId: member.uid)
            .then((value) {
          mixpanel.track("Member Accepted");
          talker.good(
              '[GroupMember] Member Accepted: (groupId: $groupId, uid: ${member.uid})');
          onDone?.call(GroupMemberCardActionType.accept);
        }).catchError((e, st) {
          talker.handle(e, st,
              '[GroupMember] Failed to accept member: (groupId: $groupId, uid: ${member.uid})');
          GlobalSnackBar.show(context, message: t.error.acceptUser);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    final handleRevoke = useCallback(() async {
      loading.value = true;
      final result = await ConfirmSlimMenuForm.show(
        context,
        title: t.group.alert.revokeInvitation(username: member.username),
        description: t.alert.actionIrreversible,
        icon: FontAwesomeIcons.check,
      );
      if (result == true) {
        GetIt.I<GroupRepository>()
            .inviteUserToGroup(
          groupId: groupId,
          userIds: [member.uid],
          value: false,
        )
            .then((value) {
          mixpanel.track("Member Invitation Revoked");
          onDone?.call(GroupMemberCardActionType.revoke);
        }).catchError((_) {
          GlobalSnackBar.show(context, message: t.error.revokeInvite);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    final handleKick = useCallback(() async {
      loading.value = true;
      final result = await ConfirmMenuForm.show(
        context,
        title: t.group.alert.kick.title(name: member.username),
        subtitle: t.group.alert.kick.subtitle,
        description: t.group.alert.kick.description,
        icon: FontAwesomeIcons.hand,
      );
      if (result == true) {
        GetIt.I<GroupRepository>()
            .kickUserFromGroup(
          groupId: groupId,
          userId: member.uid,
        )
            .then((value) {
          onDone?.call(GroupMemberCardActionType.kick);
        }).catchError((_) {
          GlobalSnackBar.show(context, message: t.error.unknown);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    final handleRemoveMod = useCallback(() async {
      loading.value = true;
      final result = await ConfirmMenuForm.show(
        context,
        title: t.group.alert.removeMod.title(name: member.username),
        subtitle: t.group.alert.removeMod.subtitle,
        description: t.group.alert.removeMod.description,
        icon: FontAwesomeIcons.rotateLeft,
      );
      if (result == true) {
        GetIt.I<GroupRepository>()
            .promoteMember(groupId: groupId, userId: member.uid, value: false)
            .then((value) {
          onDone?.call(GroupMemberCardActionType.removeMod);
        }).catchError((_) {
          GlobalSnackBar.show(context, message: t.error.unknown);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    final handlePromote = useCallback(() async {
      loading.value = true;
      final result = await ConfirmMenuForm.show(
        context,
        title: t.group.alert.promote.title(name: member.username),
        description: t.group.alert.promote.description,
        icon: FontAwesomeIcons.crown,
      );
      if (result == true) {
        GetIt.I<GroupRepository>()
            .promoteMember(groupId: groupId, userId: member.uid, value: true)
            .then((value) {
          onDone?.call(GroupMemberCardActionType.promote);
        }).catchError((_) {
          GlobalSnackBar.show(context, message: t.error.unknown);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    final handleBan = useCallback(() async {
      loading.value = true;
      final result = await ConfirmMenuForm.show(
        context,
        title: t.group.alert.ban.title(name: member.username),
        description: t.group.alert.ban.description,
        icon: FontAwesomeIcons.ban,
      );
      if (result == true) {
        GetIt.I<GroupRepository>()
            .banMember(groupId: groupId, userId: member.uid, value: true)
            .then((value) {
          onDone?.call(GroupMemberCardActionType.ban);
        }).catchError((_) {
          GlobalSnackBar.show(context, message: t.error.unknown);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    final handleUnban = useCallback(() async {
      loading.value = true;
      GetIt.I<GroupRepository>()
          .banMember(groupId: groupId, userId: member.uid, value: false)
          .then((value) {
        onDone?.call(GroupMemberCardActionType.unban);
      }).catchError((_) {
        GlobalSnackBar.show(context, message: t.error.unknown);
      }).whenComplete(() {
        loading.value = false;
      });
    }, []);

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          children: [
            UserProfileImage(
              uid: member.uid,
              profile: member.profile,
              size: 50,
              clickActionType: UserProfileImageClickActionType.profile,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        member.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      if (member.moderator != null)
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            group?.adminId == member.uid
                                ? t.general.admin
                                : t.general.moderator,
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    "@${member.username}",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            if (member.uid != group?.adminId &&
                group?.moderator != null &&
                member.uid != FirebaseAuth.instance.currentUser?.uid)
              PullDownButton(
                itemBuilder: (_) => [
                  PullDownMenuHeader(
                    leading: UserProfileImage(
                      profile: member.profile,
                      imageRadius: BorderRadius.circular(5),
                    ),
                    title: '@${member.username}',
                    icon: FontAwesomeIcons.circleUser,
                    onTap: () {
                      context.push(Uri(
                          path: '/users',
                          queryParameters: {'uid': member.uid}).toString());
                    },
                  ),
                  PullDownMenuDivider.large(),
                  if (showAccept)
                    PullDownMenuItem(
                      onTap: handleAccept,
                      icon: FontAwesomeIcons.circleCheck,
                      title: t.general.accept,
                    ),
                  if (showUndoInvite)
                    PullDownMenuItem(
                      onTap: handleRevoke,
                      icon: FontAwesomeIcons.circleXmark,
                      title: t.general.revoke,
                    ),
                  if (showKick)
                    PullDownMenuItem(
                      onTap: handleKick,
                      icon: FontAwesomeIcons.hand,
                      title: t.general.removeFromGroup,
                    ),
                  if (showPromote &&
                      FirebaseAuth.instance.currentUser?.uid == group?.adminId)
                    PullDownMenuItem(
                      onTap: handlePromote,
                      icon: FontAwesomeIcons.crown,
                      title: t.general.promoteUser(user: member.name),
                    ),
                  if (showRemoveMod &&
                      FirebaseAuth.instance.currentUser?.uid == group?.adminId)
                    PullDownMenuItem(
                      onTap: handleRemoveMod,
                      icon: FontAwesomeIcons.rotateLeft,
                      title: t.general.removeModerator,
                    ),
                  if (showBan)
                    PullDownMenuItem(
                      onTap: handleBan,
                      icon: FontAwesomeIcons.ban,
                      title: t.general.banUser(user: member.name),
                    ),
                  if (showUnban)
                    PullDownMenuItem(
                      onTap: handleUnban,
                      icon: FontAwesomeIcons.gavel,
                      title: t.general.unbanUser(user: member.name),
                    ),
                ],
                buttonBuilder: (context, showMenu) => loading.value
                    ? CircularProgressIndicator.adaptive()
                    : ShrinkingButton(
                        onTap: showMenu,
                        child: FaIcon(FontAwesomeIcons.ellipsis, size: 15),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
