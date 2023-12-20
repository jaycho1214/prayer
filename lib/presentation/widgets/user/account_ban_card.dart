import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';

class AccountBanCard extends StatelessWidget {
  const AccountBanCard({super.key});

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
              "Your account has been permanently suspended from Prayer.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
