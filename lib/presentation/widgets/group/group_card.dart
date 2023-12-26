import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/presentation/widgets/user/user_image.dart';

class GroupCard extends HookConsumerWidget {
  const GroupCard({
    super.key,
    required this.group,
    this.onTap,
  });

  final Group group;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShrinkingButton(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (onTap != null) {
          onTap?.call();
        } else {
          context.push('/groups/${group.id}');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.5,
            color: MyTheme.placeholder,
            child: group.banner != null
                ? CachedNetworkImage(
                    imageUrl: group.banner!,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          const SizedBox(height: 5),
          if (group.membershipType == 'private')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.lock,
                    size: 15,
                    color: MyTheme.placeholderText,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).onlyVisibleToYou,
                    style: TextStyle(color: MyTheme.placeholderText),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              group.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 21,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.userGroupSimple,
                                size: 12,
                                color: MyTheme.placeholderText,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${group.membersCount}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: MyTheme.placeholderText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if ((group.description ?? '') != '')
                        Text(
                          group.description ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: MyTheme.placeholderText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                UserProfileImage(
                  profile: group.admin?.profile,
                  size: 35,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
