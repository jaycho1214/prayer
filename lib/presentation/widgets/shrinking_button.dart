import 'package:flutter/material.dart';

class ShrinkingButton extends StatefulWidget {
  const ShrinkingButton({
    super.key,
    this.onTap,
    this.duration = const Duration(milliseconds: 100),
    required this.child,
  });

  final Widget child;
  final void Function()? onTap;
  final Duration duration;

  @override
  State<ShrinkingButton> createState() => _ShrinkingButtonState();
}

class _ShrinkingButtonState extends State<ShrinkingButton> {
  bool pressed = false;
  bool tapping = false;

  void onTapUp(_) {
    setState(() {
      pressed = false;
    });
  }

  void onTap() {
    setState(() {
      pressed = true;
      tapping = true;
    });
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onTapUp: onTapUp,
      onTapDown: (_) => setState(() {
        pressed = true;
      }),
      onTapCancel: () => setState(() {
        pressed = false;
      }),
      child: AnimatedScale(
        onEnd: () {
          if (tapping) {
            setState(() {
              pressed = false;
              tapping = false;
            });
          }
        },
        scale: pressed ? 0.97 : 1.0,
        duration: widget.duration,
        child: AnimatedOpacity(
          opacity: pressed ? 0.7 : 1.0,
          duration: widget.duration,
          child: widget.child,
        ),
      ),
    );
  }
}
