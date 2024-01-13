import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupBanCard extends StatelessWidget {
  const GroupBanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "This group has been permanently banned due to a violation of our policy.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
