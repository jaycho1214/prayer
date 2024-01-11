import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/errors.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/features/common/sheets/confirm_menu_form.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/common/widgets/snackbar.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
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
      GroupJoinState.joined => [
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.onSurface
        ],
      _ => [
          Theme.of(context).colorScheme.inverseSurface,
          Theme.of(context).colorScheme.onInverseSurface
        ],
    };

    final text = switch (value) {
      GroupJoinState.none => t.general.join,
      GroupJoinState.requested => t.general.requested,
      GroupJoinState.joined => t.general.joined,
    };

    return ShrinkingButton(
      onTap: () async {
        if (value == GroupJoinState.joined) {
          final result = await ConfirmMenuForm.show(
            context,
            title: t.general.leaveGroup,
            subtitle: t.alert.actionIrreversible,
            description: t.group.alert.leaveGroup,
            icon: FontAwesomeIcons.rightFromBracket,
          );
          if (result != true) {
            return;
          }
        }
        notifier.join(value == GroupJoinState.none).catchError((e) {
          if (e is AdminLeaveGroupException) {
            return GlobalSnackBar.show(context,
                message: t.error.adminLeaveGroup);
          }
          GlobalSnackBar.show(context,
              message: value != GroupJoinState.joined
                  ? t.error.joinGroup
                  : t.error.leaveGroup);
        });
      },
      child: Skeleton.leaf(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: colors[0],
            borderRadius: BorderRadius.circular(10),
            border: value != GroupJoinState.joined
                ? Border.all(color: Theme.of(context).colorScheme.outline)
                : null,
          ),
          child: Text(
            value == GroupJoinState.none && group?.invitedAt != null
                ? t.general.invited
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
