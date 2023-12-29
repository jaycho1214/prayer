import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPrayerCard extends ConsumerWidget {
  const NotificationPrayerCard({
    super.key,
    required this.item,
  });

  final CustomNotification item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(prayerNotifierProvider(item.prayerId!));
    return Skeletonizer(
      enabled: value.value == null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileImage(
              profile: item.targetUser?.profile,
              size: 40,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          S.of(context).notificationPostedPrayer(
                              item.targetUser?.username ?? ''),
                        ).boldSubString(item.targetUser?.username ?? ''),
                      ),
                      Text(
                        Formatter.fromNow(item.createdAt!),
                        style: TextStyle(color: MyTheme.placeholderText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value.value?.value ?? '',
                    style: TextStyle(color: MyTheme.placeholderText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
