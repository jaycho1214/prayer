import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class SettingsSwitchCard extends StatelessWidget {
  const SettingsSwitchCard({
    super.key,
    required this.title,
    required this.icon,
    this.description,
    this.onTap,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String? description;
  final void Function()? onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: FaIcon(
              icon,
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (description != null)
                  Text(
                    description!,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          AbsorbPointer(
            child: Switch.adaptive(
              value: value,
              onChanged: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
