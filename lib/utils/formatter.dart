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
    } else {
      double result = number / 1000000;
      return result.toStringAsFixed(1) + 'M';
    }
  }
}
