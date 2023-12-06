// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_model.freezed.dart';
part 'content_model.g.dart';

@Freezed()
class Content with _$Content {
  const factory Content({
    required int id,
    @JsonKey(name: 'user_id') required String userId,
    @Default(false) bool processed,
    String? alt,
    required String path,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Content;

  factory Content.fromJson(Map<String, Object?> json) =>
      _$ContentFromJson(json);
}
