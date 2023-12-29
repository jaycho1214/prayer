// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/model/group/group_model.dart';
import 'package:prayer/model/user/user_model.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  followed,
  group_join_requested,
  group_joined,
  group_accepted,
  group_promoted,
  prayed,
  group_corporate_posted,
  prayer_posted,
}

@Freezed()
class CustomNotification with _$CustomNotification {
  const factory CustomNotification({
    required int id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'target_user_id') String? targetUserId,
    String? message,
    required NotificationType type,
    @JsonKey(name: 'target_user') PUser? targetUser,
    @JsonKey(name: 'corporate_id') String? corporateId,
    @JsonKey(name: 'prayer_id') String? prayerId,
    @JsonKey(name: 'group_id') String? groupId,
    Group? group,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _CustomNotification;

  factory CustomNotification.fromJson(Map<String, Object?> json) =>
      _$CustomNotificationFromJson(json);

  static CustomNotification get placeholder => CustomNotification(
        id: 1,
        userId: '',
        message: 'THIS IS A PLACEHOLDER MESSAGE',
        targetUserId: '',
      );
}
