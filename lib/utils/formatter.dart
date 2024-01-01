import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prayer/generated/l10n.dart';

class Formatter {
  static String fromNow(DateTime now) {
    final diff = DateTime.now().difference(now);
    final int days = diff.inDays;
    final int weeks = days ~/ 7;
    final int years = days ~/ 365;

    if (years >= 1) {
      return '${years}y';
    } else if (weeks >= 1) {
      return '${weeks}w';
    } else if (days >= 1) {
      return '${days}d';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m';
    } else {
      return 'now';
    }
  }

  static String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double result = number / 1000;
      return result.toStringAsFixed(1) + 'k';
    } else if (number < 1000000000) {
      double result = number / 1000000;
      return result.toStringAsFixed(1) + 'M';
    } else {
      double result = number / 1000000000;
      return result.toStringAsFixed(1) + 'B';
    }
  }

  static String daysToString(List<int> days) {
    final sortedDays = days..sort();
    if (listEquals([6, 7], sortedDays)) {
      return S.current.weekend;
    } else if (listEquals(sortedDays, [1, 2, 3, 4, 5])) {
      return S.current.weekdays;
    } else if (listEquals(sortedDays, [1, 2, 3, 4, 5, 6, 7])) {
      return S.current.everyday;
    }
    return days
        .map((e) => [
              S.current.dayMon,
              S.current.dayTue,
              S.current.dayWen,
              S.current.dayThu,
              S.current.dayFri,
              S.current.daySat,
              S.current.daySun,
            ][e - 1])
        .toList()
        .join(', ');
  }
}

extension BoldSubString on Text {
  Text boldSubString(String target) {
    final textSpans = List.empty(growable: true);
    final escapedTarget = RegExp.escape(target);
    final pattern = RegExp(escapedTarget, caseSensitive: false);
    final matches = pattern.allMatches(data!);

    int currentIndex = 0;
    for (final match in matches) {
      final beforeMatch = data!.substring(currentIndex, match.start);
      if (beforeMatch.isNotEmpty) {
        textSpans.add(TextSpan(text: beforeMatch));
      }

      final matchedText = data!.substring(match.start, match.end);
      textSpans.add(
        TextSpan(
          text: matchedText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < data!.length) {
      final remainingText = data!.substring(currentIndex);
      textSpans.add(TextSpan(text: remainingText));
    }

    return Text.rich(
      TextSpan(children: <TextSpan>[...textSpans]),
    );
  }
}
