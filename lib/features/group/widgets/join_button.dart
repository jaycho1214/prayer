import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/generated/l10n.dart';
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
      GroupJoinState.none => S.of(context).join,
      GroupJoinState.requested => S.of(context).requested,
      GroupJoinState.joined => S.of(context).joined,
    };

    return ShrinkingButton(
      onTap: () async {
        if (value == GroupJoinState.joined) {
          final result = await ConfirmMenuForm.show(
            context,
            title: S.of(context).leaveGroup,
            subtitle: S.of(context).alertYouCannotUndoThisAction,
            description: S.of(context).alertLeaveGroup.split(':').toList(),
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
              message: S.of(context).errorAdminLeaveGroup,
            );
          }
          GlobalSnackBar.show(
            context,
            message: value != GroupJoinState.joined
                ? S.of(context).errorJoinGroup
                : S.of(context).errorLeaveGroup,
          );
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
                ? S.of(context).invited
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
