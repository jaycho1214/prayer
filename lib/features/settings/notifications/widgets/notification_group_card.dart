import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/group/providers/group_provider.dart';
import 'package:prayer/features/group/widgets/group_card.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationGroupCard extends ConsumerWidget {
  const NotificationGroupCard({
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
                FaIcon(
                  switch (item.type) {
                    NotificationType.group_accepted =>
                      FontAwesomeIcons.partyHorn,
                    NotificationType.group_promoted =>
                      FontAwesomeIcons.userCrown,
                    _ => FontAwesomeIcons.a,
                  },
                  color: MyTheme.onPrimary,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    switch (item.type) {
                      NotificationType.group_accepted => S
                          .of(context)
                          .notificationAccepted(group.value?.name ?? ''),
                      NotificationType.group_promoted => S
                          .of(context)
                          .notificationPromoted(group.value?.name ?? ''),
                      _ => '',
                    },
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ).boldSubString(group.value?.name ?? ''),
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
