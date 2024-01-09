import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/features/prayer/models/prayer_model.dart';

class GroupLabel extends StatelessWidget {
  const GroupLabel({
    super.key,
    required this.prayer,
  });

  final Prayer prayer;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: () => context.push('/groups/${prayer.groupId}'),
      child: Row(
        children: [
          const SizedBox(width: 10),
          FaIcon(
            FontAwesomeIcons.userGroupSimple,
            size: 13,
            color: Theme.of(context).textTheme.labelMedium?.color,
          ),
          const SizedBox(width: 5),
          Text(
            prayer.group?.name ?? '',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
