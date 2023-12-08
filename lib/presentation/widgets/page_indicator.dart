import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer/constants/theme.dart';

class PageIndicator extends HookWidget {
  const PageIndicator({
    super.key,
    required this.itemCount,
    required this.controller,
  });

  final int itemCount;
  final PageController controller;

  double interpolate(
      double value, List<double> inputRange, List<double> outputRange) {
    if (inputRange.length != outputRange.length) {
      throw ArgumentError(
          "Input and output ranges must be of the same length.");
    }

    for (int i = 0; i < inputRange.length - 1; i++) {
      if (value >= inputRange[i] && value <= inputRange[i + 1]) {
        double range = inputRange[i + 1] - inputRange[i];
        double normalizedValue = (value - inputRange[i]) / range;
        double outputRangeValue =
            normalizedValue * (outputRange[i + 1] - outputRange[i]) +
                outputRange[i];

        return outputRangeValue;
      }
    }

    if (value < inputRange.first) {
      return outputRange.first;
    } else if (value > inputRange.last) {
      return outputRange.last;
    }

    return 0.0;
  }

  Color interpolateColor(
      double value, List<double> inputRange, List<Color> colors) {
    if (inputRange.length != colors.length) {
      throw ArgumentError(
          "Input range and colors list must be of the same length.");
    }

    for (int i = 0; i < inputRange.length - 1; i++) {
      if (value >= inputRange[i] && value <= inputRange[i + 1]) {
        double fraction =
            (value - inputRange[i]) / (inputRange[i + 1] - inputRange[i]);

        return Color.lerp(colors[i], colors[i + 1], fraction) ??
            Colors.transparent;
      }
    }

    // Handle extrapolation
    if (value <= inputRange.first) {
      return colors.first;
    } else if (value >= inputRange.last) {
      return colors.last;
    }

    return Colors
        .transparent; // or throw an exception if value is not in any range
  }

  @override
  Widget build(BuildContext context) {
    final index = useState(0.0);

    final onAction = useCallback(() {
      index.value = controller.page ?? 0.0;
    }, []);

    useEffect(() {
      controller.addListener(onAction);
      return () => controller.removeListener(onAction);
    }, []);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (i) => HookBuilder(
          builder: (context) {
            final size = interpolate(
                index.value, [i - 1, i.toDouble(), i + 1], [5, 10, 5]);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: interpolateColor(index.value, [
                  i - 1,
                  i.toDouble(),
                  i + 1
                ], [
                  MyTheme.disabled,
                  MyTheme.onPrimary,
                  MyTheme.disabled,
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
