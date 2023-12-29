import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/buttons/text_button.dart';

class EmptyPrayersScreen extends StatelessWidget {
  const EmptyPrayersScreen({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  final String title;
  final String description;
  final String buttonText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              color: MyTheme.placeholderText,
            ),
          ),
          const SizedBox(height: 20),
          PrimaryTextButton(text: buttonText, onTap: onTap),
        ],
      ),
    );
  }
}
