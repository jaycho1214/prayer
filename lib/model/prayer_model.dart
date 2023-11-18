// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/model/corporate_prayer_model.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/model/placeholder.dart';
import 'package:prayer/model/user_model.dart';

part 'prayer_model.freezed.dart';
part 'prayer_model.g.dart';

@freezed
class Prayer with _$Prayer {
  @JsonSerializable(explicitToJson: true)
  const factory Prayer({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    PUser? user,
    Group? group,
    CorporatePrayer? corporate,
    bool? anon,
    @JsonKey(name: 'group_id') String? groupId,
    @JsonKey(name: 'corporate_id') String? corporateId,
    required String value,
    String? media,
    @Default(0) @JsonKey(name: 'prays_count') int praysCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'has_prayed') DateTime? hasPrayed,
    PUser? pray,
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
