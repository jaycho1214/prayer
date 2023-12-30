import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/group/providers/group_notification_provider.dart';
import 'package:prayer/features/group/widgets/forms/group_notification_form.dart';

class GroupNotificationSubscribeButton extends ConsumerWidget {
  const GroupNotificationSubscribeButton({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(groupNotificationNotifierProvider(groupId));
    return ShrinkingButton(
      onTap: () async {
        if (settings.valueOrNull == null) {
          return;
        }
        final response =
            await GroupNotificationForm.show(context, settings.value);
        if (response == null) {
          return;
        }
        ref
            .read(groupNotificationNotifierProvider(groupId).notifier)
            .updateSettings(response);
      },
      child: Container(
        alignment: Alignment.center,
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyTheme.primary,
        ),
        child: settings.valueOrNull == null
            ? CircularProgressIndicator.adaptive()
            : FaIcon(
                settings.value?.onModeratorPost == true ||
                        settings.value?.onPost == true
                    ? FontAwesomeIcons.bell
                    : FontAwesomeIcons.bellSlash,
                size: 15,
                color: MyTheme.onPrimary,
              ),
      ),
    );
  }
}
