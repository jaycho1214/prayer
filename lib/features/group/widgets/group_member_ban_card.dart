import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/group/widgets/sheets/group_banned_member_sheet.dart';
import 'package:prayer/i18n/strings.g.dart';

class GroupMemberBanCard extends StatelessWidget {
  const GroupMemberBanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: () => GroupBannedMemberSheet.show(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: Theme.of(context).colorScheme.error,
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: Theme.of(context).colorScheme.onError,
              size: 20,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                t.banned.group_member.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
