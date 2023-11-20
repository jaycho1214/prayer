// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/model/user_model.dart';

part 'prayer_pray_model.freezed.dart';
part 'prayer_pray_model.g.dart';

@freezed
class PrayerPray with _$PrayerPray {
  const factory PrayerPray({
    required PUser user,
    required int id,
    String? value,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _PrayerPray;

  factory PrayerPray.fromJson(Map<String, Object?> json) =>
      _$PrayerPrayFromJson(json);
}
