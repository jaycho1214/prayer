import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class SettingsRowCard extends StatelessWidget {
  const SettingsRowCard({
    super.key,
    required this.title,
    required this.icon,
    this.description,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? description;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              child: FaIcon(
                icon,
                color: MyTheme.onPrimary,
                size: 15,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 11,
                        color: MyTheme.placeholderText,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: MyTheme.onPrimary,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
