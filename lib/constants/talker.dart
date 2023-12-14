import 'dart:convert';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

String generateLogMessage(
  String title, {
  required Map<String, dynamic> data,
}) {
  return title +
      '\nData: ' +
      JsonEncoder.withIndent('  ').convert(data
        ..forEach((key, value) {
          value = value.toString();
        }));
}

class CustomTalkerObserver extends TalkerObserver {
  CustomTalkerObserver();

  @override
  void onError(TalkerError err) {
    Sentry.captureException(
      err.exception,
      stackTrace: err.stackTrace,
      hint: Hint.withMap({
        "message": err.message ?? "",
      }),
    );
    super.onError(err);
  }

  @override
  void onException(TalkerException exception) {
    Sentry.captureException(
      exception.exception,
      stackTrace: exception.stackTrace,
      hint: Hint.withMap({
        "message": exception.message ?? "",
      }),
    );
    super.onException(exception);
  }

  @override
  void onLog(TalkerDataInterface log) {
    super.onLog(log);
  }
}

final talker = TalkerFlutter.init(observer: CustomTalkerObserver());
