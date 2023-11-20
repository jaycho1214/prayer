import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/prayer_pray_model.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/utils/formatter.dart';

class PrayLargeCard extends StatelessWidget {
  const PrayLargeCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserProfileImage(
                profile: pray.user.profile,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  pray.user.username,
                  style: TextStyle(fontWeight: FontWeight.bold),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 20, 5),
            child: Text(
              pray.value ?? '',
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
