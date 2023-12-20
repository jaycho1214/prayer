import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/notification/notification_model.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/utils/formatter.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.item,
  });

  final CustomNotification item;

  Widget buildUserRow(BuildContext context) {
    return ShrinkingButton(
      onTap: () {
        if (item.corporateId != null) {
          context.push('/prayers/corporate/${item.corporateId}');
        } else if (item.prayerId != null) {
          context.push('/prayers/${item.prayerId}');
        } else {
          context.push(
              Uri(path: '/users', queryParameters: {'uid': item.targetUserId})
                  .toString());
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            UserProfileImage(
              profile: item.targetUser?.profile,
              size: 30,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(item.message)),
            Text(
              Formatter.fromNow(item.createdAt!),
              style: TextStyle(color: MyTheme.placeholderText),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGroupRow(BuildContext context) {
    return ShrinkingButton(
      onTap: () {
        if (item.corporateId != null) {
          context.push('/prayers.corporate/${item.corporateId}');
        } else if (item.groupId != null) {
          context.push('/groups/${item.groupId}');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: item.group!.banner!,
              width: 60,
              height: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.group!.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(item.message),
              ],
            )),
            const SizedBox(width: 10),
            Text(
              Formatter.fromNow(item.createdAt ?? DateTime.now()),
              style: TextStyle(color: MyTheme.placeholderText),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (item.group != null) {
      return buildGroupRow(context);
    }
    if (item.targetUser != null) {
      return buildUserRow(context);
    }
    return const SizedBox();
  }
}
