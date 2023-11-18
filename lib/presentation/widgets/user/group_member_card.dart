import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/bloc/group/group_bloc.dart';
import 'package:prayer/bloc/group/group_state.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/group_member_model.dart';
import 'package:prayer/presentation/widgets/button/text_button.dart';
import 'package:prayer/presentation/widgets/form/sheet/confirm_slim_menu_form.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/snackbar.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/repo/group_repository.dart';

class GroupMemberCard extends HookWidget {
  const GroupMemberCard({
    super.key,
    required this.groupId,
    required this.member,
    this.showAccept = false,
    this.showPromote = false,
  });

  final String groupId;
  final GroupMember member;
  final bool showAccept;
  final bool showPromote;

  @override
  Widget build(BuildContext context) {
    final accepted = useState(false);
    final promoted = useState(false);
    final loading = useState(false);

    final handleAccept = useCallback(() async {
      loading.value = true;
      final result = await ConfirmSlimMenuForm.show(
        context,
        title: "Accept @${member.username}?",
        description: "You cannot undo this action",
        icon: FontAwesomeIcons.check,
      );
      if (result == true) {
        context
            .read<GroupRepository>()
            .acceptMember(groupId: groupId, userId: member.uid)
            .then((value) {
          accepted.value = true;
        }).catchError((_) {
          GlobalSnackBar.show(context, message: "Failed to accept the user");
        }).whenComplete(() {
          loading.value = false;
        });
      }
      loading.value = false;
    }, []);

    final handlePromote = useCallback(() async {
      loading.value = true;
      final result = await ConfirmSlimMenuForm.show(
        context,
        title: "Promote @${member.username}?",
        description: "You cannot undo this action",
        icon: FontAwesomeIcons.userPilot,
      );
      if (result == true) {
        context
            .read<GroupRepository>()
            .promoteMember(groupId: groupId, userId: member.uid)
            .then((value) {
          accepted.value = true;
        }).catchError((_) {
          GlobalSnackBar.show(context, message: "Failed to promote the user");
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
              UserProfileImage(
                profile: member.profile,
                size: 50,
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
                        BlocBuilder<GroupBloc, GroupState>(
                          bloc: BlocProvider.of<GroupBloc>(context),
                          builder: (context, state) {
                            if (state is GroupStateLoaded) {
                              if (state.group.adminId == member.uid ||
                                  member.moderator != null) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: MyTheme.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    state.group.adminId == member.uid
                                        ? 'Admin'
                                        : 'Moderator',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }
                            }
                            return SizedBox();
                          },
                        ),
                      ],
                    ),
                    Text(
                      "@${member.username}",
                      style: TextStyle(
                        color: MyTheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              if (showAccept)
                loading.value
                    ? PlatformCircularProgressIndicator()
                    : PrimaryTextButton(
                        text: accepted.value ? "Accepted" : 'Accept',
                        inverse: accepted.value,
                        onTap: accepted.value ? null : handleAccept,
                      ),
              if (showPromote)
                loading.value
                    ? PlatformCircularProgressIndicator()
                    : PrimaryTextButton(
                        text: promoted.value ? "Promoted" : 'Promote',
                        inverse: promoted.value,
                        onTap: promoted.value ? null : handlePromote,
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
