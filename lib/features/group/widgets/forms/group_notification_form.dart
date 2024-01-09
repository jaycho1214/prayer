import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/large_text_button.dart';
import 'package:prayer/features/group/models/group_notification_settings/group_notification_settings_model.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class GroupNotificationForm extends HookWidget {
  const GroupNotificationForm({
    super.key,
    this.initialValue,
  });

  final GroupNotificationSettings? initialValue;

  static Future<GroupNotificationSettings?> show(
      BuildContext context, GroupNotificationSettings? initialValue) {
    return showModalBottomSheet<GroupNotificationSettings>(
      context: context,
      useSafeArea: true,
      builder: (context) => GroupNotificationForm(initialValue: initialValue),
    );
  }

  Widget _buildRow(
    BuildContext context, {
    required String title,
    required String description,
    void Function()? onTap,
    required bool value,
  }) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            AbsorbPointer(
              child: Checkbox(
                value: value,
                onChanged: (value) => null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue ??
        GroupNotificationSettings(onModeratorPost: false, onPost: false));
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).notifications,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const SizedBox(height: 10),
          _buildRow(
            context,
            title: S.of(context).moderator,
            description: S.of(context).groupNotificationSettingsModerator,
            value: state.value.onModeratorPost,
            onTap: () {
              final old = state.value.onModeratorPost;
              if (old) {
                state.value = GroupNotificationSettings(
                    onModeratorPost: false, onPost: false);
              } else {
                state.value = state.value.copyWith(onModeratorPost: !old);
              }
            },
          ),
          const Divider(),
          _buildRow(
            context,
            title: S.of(context).members,
            description: S.of(context).groupNotificationSettingsAll,
            value: state.value.onPost,
            onTap: () {
              final old = state.value.onPost;
              if (!old) {
                state.value = GroupNotificationSettings(
                    onModeratorPost: true, onPost: true);
              } else {
                state.value = state.value.copyWith(onPost: !old);
              }
            },
          ),
          const SizedBox(height: 20),
          LargeTextButton(
            text: S.of(context).done,
            onTap: () => context.pop(state.value.copyWith()),
          ),
        ],
      ),
    );
  }
}
