import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/features/prayer/providers/prayer_provider.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
import 'package:prayer/i18n/strings.g.dart';
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
                        child: Text.rich(
                          t.notification.postedPrayer(
                              username: TextSpan(
                            text: item.targetUser?.username ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      Text(
                        Formatter.fromNow(item.createdAt!),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value.value?.value ?? '',
                    style: Theme.of(context).textTheme.labelMedium,
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
