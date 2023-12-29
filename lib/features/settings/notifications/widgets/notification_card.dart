import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/settings/notifications/widgets/notification_corporate_card.dart';
import 'package:prayer/features/settings/notifications/widgets/notification_group_card.dart';
import 'package:prayer/features/settings/notifications/widgets/notification_moderator_group_card.dart';
import 'package:prayer/features/settings/notifications/widgets/notification_pray_card.dart';
import 'package:prayer/features/settings/notifications/widgets/notification_prayer_card.dart';
import 'package:prayer/features/settings/notifications/widgets/notification_user_card.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.item,
  });

  final CustomNotification item;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: () {
        if (item.corporateId != null) {
          context.push('/prayers/corporate/${item.corporateId}');
        } else if (item.prayerId != null) {
          context.push('/prayers/${item.prayerId}');
        } else if (item.groupId != null) {
          context.push('/groups/${item.groupId}');
        } else {
          context.push(
              Uri(path: '/users', queryParameters: {'uid': item.targetUserId})
                  .toString());
        }
      },
      child: AbsorbPointer(
        child: switch (item.type) {
          // Pray
          NotificationType.prayed => NotificationPrayCard(item: item),
          // Prayer
          NotificationType.prayer_posted => NotificationPrayerCard(item: item),
          // User
          NotificationType.followed => NotificationUserCard(item: item),
          // Group
          NotificationType.group_accepted => NotificationGroupCard(item: item),
          NotificationType.group_promoted => NotificationGroupCard(item: item),
          // Group Moderator
          NotificationType.group_joined =>
            NotificationModeratorGroupCard(item: item),
          NotificationType.group_join_requested =>
            NotificationModeratorGroupCard(item: item),
          // Corporate
          NotificationType.group_corporate_posted =>
            NotificationCorporateCard(item: item),
        },
      ),
    );
  }
}
