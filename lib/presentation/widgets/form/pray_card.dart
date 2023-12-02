import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/prayer_pray_model.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:pull_down_button/pull_down_button.dart';

class PrayCard extends StatelessWidget {
  const PrayCard({
    super.key,
    required this.pray,
    this.onDelete,
  });

  final PrayerPray pray;
  final void Function()? onDelete;

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
                  pray.value == null
                      ? S.of(context).someoneHasPrayed(pray.user.username)
                      : pray.user.username,
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
              PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuHeader(
                    leading: UserProfileImage(profile: pray.user.profile),
                    title: '@${pray.user.username}',
                    onTap: () => context.push(Uri(
                        path: '/users',
                        queryParameters: {'uid': pray.user.uid}).toString()),
                  ),
                  PullDownMenuDivider.large(),
                  PullDownMenuItem(
                    enabled:
                        pray.user.uid == FirebaseAuth.instance.currentUser?.uid,
                    isDestructive: true,
                    onTap: onDelete,
                    title: 'Delete',
                    icon: FontAwesomeIcons.trash,
                  ),
                ],
                buttonBuilder: (context, showMenu) => ShrinkingButton(
                  onTap: showMenu,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FaIcon(
                      FontAwesomeIcons.lightEllipsisVertical,
                      color: MyTheme.placeholderText,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (pray.value != null)
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
