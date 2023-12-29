import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/features/group/widgets/group_card.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationModeratorGroupCard extends ConsumerWidget {
  const NotificationModeratorGroupCard({
    super.key,
    required this.item,
  });

  final CustomNotification item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupNotifierProvider(item.groupId!));
    return Skeletonizer(
      enabled: group.value == null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileImage(
                  profile: item.targetUser?.profile,
                  size: 40,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    switch (item.type) {
                      NotificationType.group_join_requested => S
                          .of(context)
                          .notificationJoinRequested(
                              item.targetUser?.username ?? ''),
                      NotificationType.group_joined => S
                          .of(context)
                          .notificationJoinedGroup(
                              item.targetUser?.username ?? ''),
                      _ => '',
                    },
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ).boldSubString(item.targetUser?.username ?? ''),
                ),
                Text(
                  Formatter.fromNow(item.createdAt!),
                  style: TextStyle(color: MyTheme.placeholderText),
                ),
              ],
            ),
            if (group.value != null)
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 10, top: 10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MyTheme.disabled, width: 1.0),
                  ),
                  child: GroupCard(
                    group: group.value!,
                    imageRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
