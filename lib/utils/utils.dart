import 'package:flutter/material.dart';

class Utils {
  static double interpolate(
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

  static Color interpolateColor(
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
}
