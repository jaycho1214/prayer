import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/presentation/widgets/chip/statistics_chip.dart';
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
          Stack(
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
              Positioned(
                left: 10,
                top: 10,
                child: UserChip(
                  profile: group.admin?.profile,
                  name: group.admin?.name,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: StatisticsChip(
                  icon: FontAwesomeIcons.lightUsers,
                  value: group.membersCount,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
