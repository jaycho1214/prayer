import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';

class GroupBanCard extends StatelessWidget {
  const GroupBanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: MyTheme.error,
      child: Row(
        children: [
          FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: MyTheme.onPrimary,
            size: 20,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              "This group has been permanently banned due to a violation of our policy.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
