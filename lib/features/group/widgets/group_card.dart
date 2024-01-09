import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/user/widgets/user_image.dart';

class GroupCard extends HookConsumerWidget {
  const GroupCard({
    super.key,
    required this.group,
    this.imageRadius = BorderRadius.zero,
    this.onTap,
  });

  final Group group;
  final BorderRadiusGeometry imageRadius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShrinkingButton(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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
            color: group.banner == null
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            child: group.banner != null
                ? ClipRRect(
                    borderRadius: imageRadius,
                    child: CachedNetworkImage(
                      imageUrl: group.banner!,
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 5),
          if (group.membershipType == 'private')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.lock,
                    size: 15,
                    color: Theme.of(context).textTheme.labelMedium?.color,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).onlyVisibleToYou,
                    style: Theme.of(context).textTheme.labelMedium,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.color,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${group.membersCount}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if ((group.description ?? '') != '')
                        Text(
                          group.description ?? '',
                          style: Theme.of(context).textTheme.labelSmall,
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
