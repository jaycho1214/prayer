import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TextChip extends StatelessWidget {
  const TextChip({
    super.key,
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyTheme.surfaceDim,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                icon,
                color: MyTheme.onPrimary,
                size: 12,
              ),
              const SizedBox(width: 5),
              Text(
                value,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
