import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:prayer/i18n/strings.g.dart';

class WrittenByMeLabel extends StatelessWidget {
  const WrittenByMeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.lock,
            size: 11,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 5),
          Text(
            t.general.myPost,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
