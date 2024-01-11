import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/model/prayer_pray/prayer_pray_model.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/widgets/user_image.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserProfileImage(
                profile: pray.user.profile,
                uid: pray.user.uid,
                clickActionType: UserProfileImageClickActionType.profile,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  t.prayer.someoneHasPrayed(
                    username: TextSpan(
                      text: pray.user.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                Formatter.fromNow(pray.createdAt),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(width: 10),
              PullDownButton(
                itemBuilder: (context) => [
                  PullDownMenuHeader(
                    leading: AbsorbPointer(
                      child: UserProfileImage(
                        profile: pray.user.profile,
                        imageRadius: BorderRadius.circular(5),
                      ),
                    ),
                    icon: FontAwesomeIcons.circleUser,
                    title: '@${pray.user.username}',
                    onTap: () => context.push(Uri(
                        path: '/users',
                        queryParameters: {'uid': pray.user.uid}).toString()),
                  ),
                  PullDownMenuDivider.large(),
                  PullDownMenuItem(
                    onTap: () {
                      context.push(Uri(
                              path: '/report',
                              queryParameters: {'prayId': pray.id.toString()})
                          .toString());
                    },
                    title: t.general.report,
                    icon: FontAwesomeIcons.flag,
                    isDestructive: true,
                  ),
                  PullDownMenuItem(
                    enabled:
                        pray.user.uid == FirebaseAuth.instance.currentUser?.uid,
                    isDestructive: true,
                    onTap: onDelete,
                    title: t.general.delete,
                    icon: FontAwesomeIcons.trash,
                  ),
                ],
                buttonBuilder: (context, showMenu) => ShrinkingButton(
                  onTap: showMenu,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FaIcon(
                      FontAwesomeIcons.lightEllipsisVertical,
                      color: Theme.of(context).disabledColor,
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
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
