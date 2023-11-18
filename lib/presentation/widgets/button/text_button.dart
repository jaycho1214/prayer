import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton({
    super.key,
    required this.text,
    this.loading,
    this.onTap,
    this.inverse = false,
    this.backgroundColor,
  });

  final String text;
  final void Function()? onTap;
  final bool? loading;
  final bool? inverse;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return PlatformCircularProgressIndicator();
    }
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ??
              (inverse == true ? MyTheme.onPrimary : MyTheme.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: inverse == true ? Colors.black : MyTheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
