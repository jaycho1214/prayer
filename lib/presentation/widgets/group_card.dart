import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/presentation/widgets/chip/user_chip.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

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
          Hero(
            tag: 'group.${group.id}.banner',
            child: Container(
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
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UserChip(
                      uid: group.adminId,
                      profile: group.admin?.profile,
                      name: group.admin?.name,
                      username: group.admin?.username,
                    ),
                    Spacer(),
                    Text(
                      '${group.membersCount} Members',
                      style: TextStyle(
                        color: MyTheme.placeholderText,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    group.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
