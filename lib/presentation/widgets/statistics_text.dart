import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/utils/formatter.dart';

class StatisticsText extends StatelessWidget {
  const StatisticsText({super.key, required this.value, required this.text});

  final int value;
  final String text;

  @override
  Widget build(context) {
    return Row(
      children: [
        Text(
          "${Formatter.formatNumber(value)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(color: MyTheme.placeholderText),
        ),
      ],
    );
  }
}
