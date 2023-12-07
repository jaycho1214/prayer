// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_member_model.freezed.dart';
part 'group_member_model.g.dart';

@freezed
class GroupMember with _$GroupMember {
  const factory GroupMember({
    required String uid,
    required String name,
    required String username,
    required String? profile,
    DateTime? moderator,
  }) = _GroupMember;

  factory GroupMember.fromJson(Map<String, Object?> json) =>
      _$GroupMemberFromJson(json);
}
