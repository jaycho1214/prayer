import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/prayer_pray_model.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/utils/formatter.dart';

class PraySlimCard extends StatelessWidget {
  const PraySlimCard({
    super.key,
    required this.pray,
  });

  final PrayerPray pray;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          UserProfileImage(
            profile: pray.user.profile,
            size: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${pray.user.username} has prayed for you',
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            Formatter.fromNow(pray.createdAt),
            style: TextStyle(
              color: MyTheme.outline,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
