import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prayer/features/common/widgets/buttons/shrinking_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.iconPath,
    required this.text,
    this.onTap,
    this.loading = false,
    this.imageColor,
  });

  final void Function()? onTap;
  final String iconPath;
  final String text;
  final bool loading;
  final Color? imageColor;

  void handleTap() {
    HapticFeedback.lightImpact();
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: handleTap,
      child: Container(
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
          ),
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState:
                loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstChild: Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  child: PlatformCircularProgressIndicator(),
                  width: 15,
                  height: 15,
                ),
              ),
            ),
            secondChild: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  color: imageColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          )),
    );
  }
}
