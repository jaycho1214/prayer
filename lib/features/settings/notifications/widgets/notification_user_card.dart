import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/utils/formatter.dart';

class NotificationUserCard extends StatelessWidget {
  const NotificationUserCard({
    super.key,
    required this.item,
  });

  final CustomNotification item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AbsorbPointer(
            child: UserProfileImage(
              profile: item.targetUser?.profile,
              size: 40,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              S.of(context).notificationFollow(item.targetUser?.username ?? ''),
            ).boldSubString(item.targetUser?.username ?? ''),
          ),
          Text(
            Formatter.fromNow(item.createdAt!),
            style: TextStyle(color: MyTheme.placeholderText),
          ),
        ],
      ),
    );
  }
}
