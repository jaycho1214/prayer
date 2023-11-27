import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_menu_form.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/providers/group/group_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum GroupJoinState {
  none,
  requested,
  joined,
}

class JoinButton extends HookConsumerWidget {
  const JoinButton({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(GroupNotifierProvider(groupId)).value;
    final notifier = ref.watch(GroupNotifierProvider(groupId).notifier);

    final value = useMemoized(() {
      return group?.acceptedAt != null
          ? GroupJoinState.joined
          : group?.joinedAt != null
              ? GroupJoinState.requested
              : GroupJoinState.none;
    }, [group]);

    final colors = switch (value) {
      GroupJoinState.none => [MyTheme.onPrimary, MyTheme.surface],
      GroupJoinState.requested => [MyTheme.surfaceDim, MyTheme.outline],
      GroupJoinState.joined => [MyTheme.surface, MyTheme.onPrimary],
    };

    final text = switch (value) {
      GroupJoinState.none => 'Join',
      GroupJoinState.requested => 'Requested',
      GroupJoinState.joined => 'Joined',
    };

    return ShrinkingButton(
      onTap: () async {
        if (value == GroupJoinState.joined) {
          final result = await ConfirmMenuForm.show(
            context,
            title: "Leave group",
            subtitle: "You cannot undo this action",
            description: [
              "\u{26A0} You need to be reaccepted to join the group.",
              "\u{26A0} You need to be repromoted to regain moderator status.",
              "\u{26A0} None of your prayers will be deleted.",
            ],
            icon: FontAwesomeIcons.rightFromBracket,
          );
          if (result != true) {
            return;
          }
        }
        notifier.join(value == GroupJoinState.none).catchError((e) {
          if (e is AdminLeaveGroupException) {
            return GlobalSnackBar.show(
              context,
              message: "Admin cannot leave the group",
            );
          }
          GlobalSnackBar.show(
            context,
            message:
                "Failed to ${value != GroupJoinState.joined ? 'join' : 'leave'} the group",
          );
        });
      },
      child: Skeleton.leaf(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: colors[0],
            borderRadius: BorderRadius.circular(10),
            border: value != GroupJoinState.none
                ? Border.all(color: MyTheme.outline)
                : null,
          ),
          child: Text(
            value == GroupJoinState.none && group?.invitedAt != null
                ? 'Invited'
                : text,
            style: TextStyle(
              fontSize: 15,
              color: colors[1],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
