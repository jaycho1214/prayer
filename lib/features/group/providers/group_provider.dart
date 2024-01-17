import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synchronized/synchronized.dart';

part 'group_provider.g.dart';

final groupJoinLock = new Lock();

@riverpod
class GroupNotifier extends _$GroupNotifier {
  @override
  FutureOr<Group?> build(String? groupId) async {
    try {
      if (groupId == null) {
        return null;
      }
      final data = await GetIt.I<GroupRepository>().fetchGroup(groupId);
      return data;
    } catch (error, stackTrace) {
      talker.handle(
          error,
          stackTrace,
          generateLogMessage('[Group] Failed to fetch', data: {
            'groupId': groupId,
          }));
      state = AsyncError(error, stackTrace);
      return null;
    }
  }

  Future<void> join(bool value) async {
    await groupJoinLock.synchronized(() async {
      final backup = state.value;
      try {
        if (backup == null) {
          throw ActionBeforeFetchedException();
        }
        state = AsyncValue.data(backup.copyWith(
          joinedAt: value ? DateTime.now() : null,
          acceptedAt: value
              ? backup.membershipType == 'open'
                  ? DateTime.now()
                  : null
              : null,
        ));
        final data = await GetIt.I<GroupRepository>().joinGroup(
          groupId: this.groupId!,
          value: value,
        );
        if (value) {
          if (data == null) {
            state = AsyncValue.data(backup.copyWith(
              joinedAt: DateTime.now(),
              acceptedAt: null,
            ));
          } else {
            state = AsyncValue.data(backup.copyWith(
              joinedAt: DateTime.now(),
              acceptedAt: DateTime.now(),
            ));
          }
        }
      } catch (error, stackTrace) {
        talker.handle(
            error,
            stackTrace,
            generateLogMessage('[Group] Failed to join the group', data: {
              'groupId': groupId,
            }));
        state = AsyncValue.data(backup);
        rethrow;
      }
    });
  }
}
