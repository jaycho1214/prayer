// ignore_for_file: invalid_annotation_target
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_model.freezed.dart';
part 'reminder_model.g.dart';

@Freezed()
class Reminder with _$Reminder {
  @JsonSerializable(explicitToJson: true)
  const factory Reminder({
    required int id,
    @DaysConverter() List<int>? days,
    required String value,
    @TimeOfDayConverter() required DateTime time,
    @JsonKey(name: 'corporate_id') String? corporateId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, Object?> json) =>
      _$ReminderFromJson(json);
}

class DaysConverter implements JsonConverter<List<int>?, String?> {
  const DaysConverter();

  @override
  List<int>? fromJson(String? json) =>
      json == null ? null : List<int>.from(jsonDecode(json));

  @override
  String? toJson(List<int>? object) =>
      object == null ? null : jsonEncode(object);
}

class TimeOfDayConverter implements JsonConverter<DateTime, String?> {
  const TimeOfDayConverter();

  @override
  DateTime fromJson(String? json) {
    final splits = json!.split(':');
    return DateTime.now().toLocal().copyWith(
          hour: int.parse(splits[0]),
          minute: int.parse(splits[1]),
          second: 0,
          microsecond: 0,
          millisecond: 0,
        );
  }

  @override
  String? toJson(DateTime? object) => object == null
      ? null
      : '${object.hour.toString().padLeft(2, '0')}:${object.minute.toString().padLeft(2, '0')}:00';
}
