import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/group/models/group_member/group_member_model.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';
import 'package:prayer/features/common/sheets/confirm_slim_menu_form.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/repo/group_repository.dart';

enum GroupMemberCardActionType { accept, revoke }

class GroupMemberCard extends HookConsumerWidget {
  const GroupMemberCard({
    super.key,
    required this.groupId,
    required this.member,
    this.onDone,
    this.showAccept = false,
    this.showUndoInvite = false,
  });

  final String groupId;
  final GroupMember member;
  final bool showAccept;
  final bool showUndoInvite;
  final void Function(GroupMemberCardActionType)? onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accepted = useState(false);
    final revoked = useState(false);
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
          accepted.value = true;
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
          revoked.value = true;
          onDone?.call(GroupMemberCardActionType.revoke);
        }).catchError((_) {
          GlobalSnackBar.show(context, message: t.error.revokeInvite);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    return ShrinkingButton(
      onTap: () => context.push(
          Uri(path: '/users', queryParameters: {'uid': member.uid}).toString()),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            children: [
              AbsorbPointer(
                child: UserProfileImage(
                  profile: member.profile,
                  size: 50,
                ),
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
              if (showAccept)
                loading.value
                    ? PlatformCircularProgressIndicator()
                    : PrimaryTextButton(
                        text: accepted.value
                            ? t.general.accepted
                            : t.general.accept,
                        inverse: accepted.value,
                        onTap: accepted.value ? null : handleAccept,
                      ),
              if (showUndoInvite)
                loading.value
                    ? PlatformCircularProgressIndicator()
                    : PrimaryTextButton(
                        text: revoked.value
                            ? t.general.revoked
                            : t.general.revoke,
                        inverse: revoked.value,
                        onTap: revoked.value ? null : handleRevoke,
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
