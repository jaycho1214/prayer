import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/presentation/widgets/shrinking_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.onTap,
    this.loading = false,
    required this.iconPath,
    required this.text,
  });

  final void Function()? onTap;
  final String iconPath;
  final String text;
  final bool loading;

  void handleTap() {
    HapticFeedback.lightImpact();
    onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ShrinkingButton(
      onTap: handleTap,
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: MyTheme.outline, width: 1.0),
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
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: MyTheme.onPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
