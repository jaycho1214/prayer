import 'package:flutter/material.dart';
import 'package:prayer/utils/formatter.dart';

class StatisticsText extends StatelessWidget {
  const StatisticsText({super.key, required this.value, required this.text});

  final int value;
  final String text;

  @override
  Widget build(context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
          text: Formatter.formatNumber(value),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        TextSpan(
          text: ' $text',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    ));
  }
}
