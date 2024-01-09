import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/features/group/providers/group_provider.dart';

class GroupInformationSheet extends ConsumerWidget {
  const GroupInformationSheet({
    super.key,
    required this.groupId,
  });

  final String groupId;

  static Future<bool?> show(BuildContext context, String groupId) {
    return showModalBottomSheet<bool>(
        elevation: 0,
        context: context,
        builder: (context) {
          return GroupInformationSheet(groupId: groupId);
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(GroupNotifierProvider(groupId)).value;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.users,
            size: 20,
          ),
          const SizedBox(height: 10),
          Text(
            S.of(context).titleGroupType(switch (group?.membershipType) {
                  'restricted' => S.of(context).restricted,
                  'private' => S.of(context).private,
                  _ => S.of(context).open,
                }),
            style: Theme.of(context).textTheme.displaySmall,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                switch (group?.membershipType) {
                  'open' => S.of(context).titleMembershipTypeOpen,
                  'restricted' => S.of(context).titleMembershipTypeRestricted,
                  'private' => S.of(context).titleMembershipTypePrivate,
                  _ => '1.',
                },
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                S.of(context).titleMemberCanPostOnly,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              if (group?.createdAt != null)
                Text(
                  S.of(context).groupEstablishedAt(
                      Jiffy.parseFromDateTime(group!.createdAt!)
                          .toLocal()
                          .yMMMd),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
          ),
          const SizedBox(height: 40),
          LargeIconButton(
            icon: FontAwesomeIcons.xmark,
            onTap: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
