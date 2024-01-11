import 'package:flutter/material.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/features/user/widgets/user_image.dart';

import 'package:prayer/i18n/strings.g.dart';
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
            child: Text.rich(
              t.notification.someoneFollowed(
                username: TextSpan(
                  text: item.targetUser?.username ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Text(
            Formatter.fromNow(item.createdAt!),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
