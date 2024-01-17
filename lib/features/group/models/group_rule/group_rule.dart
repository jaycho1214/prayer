// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_rule.freezed.dart';
part 'group_rule.g.dart';

@freezed
class GroupRule with _$GroupRule {
  const GroupRule._();

  const factory GroupRule({
    int? id,
    required String title,
    required String description,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _GroupRule;

  factory GroupRule.fromJson(Map<String, Object?> json) =>
      _$GroupRuleFromJson(json);
}
