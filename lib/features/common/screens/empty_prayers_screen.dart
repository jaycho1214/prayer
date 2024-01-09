import 'package:flutter/material.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';

class EmptyPrayersScreen extends StatelessWidget {
  const EmptyPrayersScreen({
    super.key,
    required this.title,
    required this.description,
    this.buttonText,
    this.onTap,
  });

  final String title;
  final String description;
  final String? buttonText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).disabledColor,
            ),
          ),
          if (buttonText != null) ...[
            const SizedBox(height: 20),
            PrimaryTextButton(text: buttonText!, onTap: onTap),
          ],
        ],
      ),
    );
  }
}
