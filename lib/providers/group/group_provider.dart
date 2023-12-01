import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:synchronized/synchronized.dart';

part 'group_provider.g.dart';

final groupJoinLock = new Lock();

@riverpod
class GroupNotifier extends _$GroupNotifier {
  @override
  FutureOr<Group?> build(String groupId) async {
    try {
      final data = await GetIt.I<GroupRepository>().fetchGroup(groupId);
      return data;
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      return null;
    }
  }

  Future<void> join(bool value) async {
    await groupJoinLock.synchronized(() async {
      final backup = state.value;
      try {
        if (backup == null) {
          return;
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
          groupId: this.groupId,
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
        talker.error("Error while joining the group", error);
        state = AsyncValue.data(backup);
        Sentry.captureException(error, stackTrace: stackTrace);
        rethrow;
      }
    });
  }
}
