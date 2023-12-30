import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/group/models/group_notification_settings/group_notification_settings_model.dart';
import 'package:prayer/repo/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_notification_provider.g.dart';

@riverpod
class GroupNotificationNotifier extends _$GroupNotificationNotifier {
  @override
  FutureOr<GroupNotificationSettings> build(String groupId) async {
    try {
      final data = await GetIt.I<NotificationRepository>()
          .fetchGroupNotificationSettings(groupId);
      return data ??
          GroupNotificationSettings(
            onModeratorPost: false,
            onPost: false,
          );
    } catch (error, stackTrace) {
      talker.handle(
          error,
          stackTrace,
          generateLogMessage('[Group] Failed to fetch', data: {
            'groupId': groupId,
          }));
      return GroupNotificationSettings(
        onModeratorPost: false,
        onPost: false,
      );
    }
  }

  Future<void> updateSettings(GroupNotificationSettings newValue) async {
    await GetIt.I<NotificationRepository>()
        .createGroupNotificationSettings(groupId, newValue);
    state = AsyncValue.data(newValue);
  }
}
