// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/model/content/content_model.dart';
import 'package:prayer/model/corporate_prayer/corporate_prayer_model.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/model/placeholder.dart';
import 'package:prayer/model/user/user_model.dart';

part 'prayer_model.freezed.dart';
part 'prayer_model.g.dart';

@freezed
class Prayer with _$Prayer {
  @JsonSerializable(explicitToJson: true)
  const factory Prayer({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'group_id') String? groupId,
    bool? anon,
    required String value,
    @Default([]) List<Content> contents,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'corporate_id') String? corporateId,
    @Default(0) @JsonKey(name: 'prays_count') int praysCount,
    @JsonKey(name: 'has_prayed') DateTime? hasPrayed,
    PUser? user,
    PUser? pray,
    Group? group,
    CorporatePrayer? corporate,
  }) = _Prayer;

  factory Prayer.fromJson(Map<String, Object?> json) => _$PrayerFromJson(json);

  static Prayer get placeholder => Prayer(
        id: '',
        userId: '',
        groupId: '',
        value: LoremIpsum,
        user: PUser.placeholder,
      );
}
