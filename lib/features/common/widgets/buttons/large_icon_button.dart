import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class LargeIconButton extends StatelessWidget {
  const LargeIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.width,
    this.destructive = false,
  });

  final double? width;
  final IconData icon;
  final bool destructive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: destructive
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FaIcon(
          icon,
          size: 20,
          color: destructive
              ? Theme.of(context).colorScheme.onError
              : Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
