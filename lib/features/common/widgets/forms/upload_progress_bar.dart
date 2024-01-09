import 'package:flutter/material.dart';

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
            color: Theme.of(context).disabledColor,
            width: MediaQuery.of(context).size.width,
            height: 5,
          ),
          Container(
            color: Theme.of(context).colorScheme.onBackground,
            width: MediaQuery.of(context).size.width * progress,
            height: 5,
          ),
        ],
      ),
    );
  }
}
