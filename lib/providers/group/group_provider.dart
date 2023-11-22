import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_provider.g.dart';

@riverpod
class GroupNotifier extends _$GroupNotifier {
  @override
  FutureOr<Group?> build(String groupId) async {
    final data = await GetIt.I<GroupRepository>().fetchGroup(groupId);
    return data;
  }

  Future<void> join(bool value) async {
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
    } catch (e) {
      talker.error("Error while joining the group", e);
      state = AsyncValue.data(backup);
      rethrow;
    }
  }
}