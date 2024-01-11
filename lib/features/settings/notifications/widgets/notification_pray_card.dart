import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/features/user/widgets/user_image.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPrayCard extends HookWidget {
  const NotificationPrayCard({
    super.key,
    required this.item,
  });

  final CustomNotification item;

  Widget _buildRowText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text.rich(
            t.notification.prayed(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (item.prayId == null) {
      return const SizedBox();
    }
    return FutureBuilder(
      future: GetIt.I<PrayerRepository>().fetchPray(item.prayId!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          talker.handle(snapshot.error!, null,
              "[PrayerPray] Failed to fetch prayer pray");
        }
        return Skeletonizer(
          enabled: snapshot.data == null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserProfileImage(
                  profile: item.targetUser?.profile,
                  size: 40,
                ),
                const SizedBox(width: 20),
                if (snapshot.data?.value == null)
                  Expanded(child: _buildRowText(context)),
                if (snapshot.data?.value != null)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRowText(context),
                        const SizedBox(height: 5),
                        Text(
                          snapshot.data?.value ?? '',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
