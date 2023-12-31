// ignore_for_file: invalid_annotation_target
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/features/corporate_prayer/models/reminder/reminder_model.dart';
import 'package:prayer/model/user/user_model.dart';

part 'corporate_prayer_model.freezed.dart';
part 'corporate_prayer_model.g.dart';

@Freezed()
class CorporatePrayer with _$CorporatePrayer {
  const factory CorporatePrayer({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    PUser? user,
    Group? group,
    @JsonKey(name: 'group_id') required String groupId,
    required String title,
    String? description,
    Reminder? reminder,
    @CorporatePrayerConverter() List<String>? prayers,
    @Default(0) @JsonKey(name: 'prayers_count') int prayersCount,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _CorporatePrayer;

  factory CorporatePrayer.fromJson(Map<String, Object?> json) =>
      _$CorporatePrayerFromJson(json);

  static CorporatePrayer get placeholder => CorporatePrayer(
        id: '',
        userId: '',
        groupId: '',
        title: 'Title',
        description: 'Description',
        user: PUser.placeholder,
      );
}

class CorporatePrayerConverter
    implements JsonConverter<List<String>?, String?> {
  const CorporatePrayerConverter();

  @override
  List<String>? fromJson(String? json) =>
      json == null ? null : List<String>.from(jsonDecode(json));

  @override
  String? toJson(List<String>? object) =>
      object == null ? null : jsonEncode(object);
}
