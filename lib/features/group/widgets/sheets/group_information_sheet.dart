import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';
import 'package:prayer/i18n/strings.g.dart';
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
        isScrollControlled: true,
        builder: (context) {
          return GroupInformationSheet(groupId: groupId);
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(GroupNotifierProvider(groupId)).valueOrNull;

    if (group == null) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

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
            t.group.alert.detail.title(
                membershipType: switch (group.membershipType) {
              'restricted' => t.general.restricted,
              'private' => t.general.private,
              _ => t.general.open,
            }),
            style: Theme.of(context).textTheme.displaySmall,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FaIcon(switch (group.membershipType) {
                    'open' => FontAwesomeIcons.lockOpen,
                    _ => FontAwesomeIcons.lock
                  }),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      t['group.alert.detail.description.membershipType.${group.membershipType}'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (group.createdAt != null)
                Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendar),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text.rich(
                        t.group.alert.detail.description.establishedAt(
                          establishedAt: TextSpan(
                            text: Jiffy.parseFromDateTime(group.createdAt!)
                                .toLocal()
                                .yMMMd,
                            style: TextStyle(color: Colors.blue),
                          ),
                          user: TextSpan(
                            text: group.admin?.name ?? '',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context
                                  .push('/users?uid=${group.admin?.uid}'),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
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
