import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/group/models/group_notification_settings_model.dart';
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
      backgroundColor: MyTheme.sheetSurface,
      barrierColor: Colors.white.withAlpha(15),
      builder: (context) => GroupNotificationForm(initialValue: initialValue),
    );
  }

  Widget _buildRow({
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
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: MyTheme.placeholderText,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: value,
              onChanged: (value) => null,
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: MyTheme.sheetSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            S.of(context).notifications,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          const SizedBox(height: 10),
          _buildRow(
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
              }),
          Divider(color: MyTheme.outline),
          _buildRow(
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
              }),
          ShrinkingButton(
            onTap: () => context.pop(state.value.copyWith()),
            child: Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: MyTheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                S.of(context).done,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
