import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/bloc/group/group_bloc.dart';
import 'package:prayer/bloc/group/group_event.dart';
import 'package:prayer/bloc/group/group_state.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_menu_form.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum GroupJoinState {
  none,
  requested,
  joined,
}

class JoinButton extends StatelessWidget {
  const JoinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        final value = switch (state) {
          GroupStateLoaded(group: final group) ||
          GroupStateRefreshing(group: final group) =>
            group.acceptedAt != null
                ? GroupJoinState.joined
                : group.joinedAt != null
                    ? GroupJoinState.requested
                    : GroupJoinState.none,
          _ => GroupJoinState.none,
        };

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
            context
                .read<GroupBloc>()
                .add(GroupEventJoin(value == GroupJoinState.none));
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
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: colors[1],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
