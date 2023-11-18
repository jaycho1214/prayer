import 'package:flutter/material.dart';
import 'package:prayer/constants/theme.dart';

class UploadProgressBar extends StatelessWidget {
  const UploadProgressBar({
    super.key,
    this.progress = 0.0,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      crossFadeState: progress == 0.0
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      secondChild: const SizedBox.shrink(),
      firstChild: Stack(
        children: [
          Container(
            color: MyTheme.disabled,
            width: MediaQuery.of(context).size.width,
            height: 5,
          ),
          Container(
            color: MyTheme.onPrimary,
            width: MediaQuery.of(context).size.width * progress,
            height: 5,
          ),
        ],
      ),
    );
  }
}
