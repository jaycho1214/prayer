import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/generated/l10n.dart';

class WrittenByMeLabel extends StatelessWidget {
  const WrittenByMeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        FaIcon(
          FontAwesomeIcons.lock,
          size: 11,
          color: Theme.of(context).textTheme.labelMedium?.color,
        ),
        const SizedBox(width: 5),
        Text(
          S.of(context).postedByMe,
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
