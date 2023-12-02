import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/generated/l10n.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';
import 'package:prayer/providers/group/group_provider.dart';

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
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white.withAlpha(15),
        builder: (context) {
          return GroupInformationSheet(groupId: groupId);
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(GroupNotifierProvider(groupId)).value;

    return Container(
      width: double.infinity,
      height: 400,
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(
        10,
        0,
        10,
        MediaQuery.of(context).padding.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: MyTheme.sheetSurface,
        ),
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.users,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              S.of(context).titleGroupType(switch (group?.membershipType) {
                    'restricted' => S.of(context).restricted,
                    'private' => S.of(context).private,
                    _ => S.of(context).open,
                  }),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    switch (group?.membershipType) {
                      'open' => S.of(context).titleMembershipTypeOpen,
                      'restricted' =>
                        S.of(context).titleMembershipTypeRestricted,
                      'private' => S.of(context).titleMembershipTypePrivate,
                      _ => '1.',
                    },
                    style: TextStyle(
                      color: MyTheme.placeholderText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).titleMemberCanPostOnly,
                    style: TextStyle(
                      color: MyTheme.placeholderText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (group?.createdAt != null)
                    Text(
                      S.of(context).groupEstablishedAt(
                          Jiffy.parseFromDateTime(group!.createdAt!)
                              .toLocal()
                              .yMMMd),
                      style: TextStyle(
                        color: MyTheme.placeholderText,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ShrinkingButton(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
