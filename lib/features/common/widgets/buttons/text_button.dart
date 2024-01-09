import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

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
              (inverse == true
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: inverse == true
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
