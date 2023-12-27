import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';
import 'package:prayer/utils/formatter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StatisticsChip extends StatelessWidget {
  const StatisticsChip({
    super.key,
    required this.icon,
    required this.value,
    this.onTap,
    this.inverted = false,
    this.loading = false,
  });

  final void Function()? onTap;
  final IconData icon;
  final int value;
  final bool inverted;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: ShrinkingButton(
        onTap: onTap,
        child: FittedBox(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: inverted ? MyTheme.onPrimary : MyTheme.surfaceDim,
              borderRadius: BorderRadius.circular(10),
            ),
            child: loading
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: inverted ? Colors.black : Colors.white,
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        icon,
                        color: inverted ? MyTheme.surface : MyTheme.onPrimary,
                        size: 12,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        Formatter.formatNumber(value),
                        style: TextStyle(
                          fontSize: 12,
                          color: inverted ? MyTheme.surface : MyTheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
