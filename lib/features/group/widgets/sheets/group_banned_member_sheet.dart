import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/large_icon_button.dart';
import 'package:prayer/i18n/strings.g.dart';

class GroupBannedMemberSheet extends StatelessWidget {
  const GroupBannedMemberSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      elevation: 0,
      context: context,
      isScrollControlled: true,
      builder: (context) => GroupBannedMemberSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: FaIcon(
              FontAwesomeIcons.ban,
              size: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            t.banned.group_member.title,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ...t.banned.group_member.actions.asMap().entries.map(
                (e) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${e.key + 1}.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        e.value,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
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
