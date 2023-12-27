import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/features/auth/providers/auth_provider.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<PUser?> build({String? uid, String? username}) async {
    try {
      if (uid == null && username == null) {
        return null;
      }
      final data = await GetIt.I<UserRepository>().fetchUser(
        uid: uid,
        username: username,
      );
      if (data?.uid == FirebaseAuth.instance.currentUser?.uid) {
        ref.watch(authNotifierProvider.notifier).setUser(data);
      }
      return data;
    } catch (e, st) {
      talker.handle(
        e,
        st,
        generateLogMessage("[User] Failed to fetch user", data: {
          'uid': uid,
          'username': username,
        }),
      );
      return null;
    }
  }

  Future<void> followUser(bool value) async {
    if (state.value?.uid == null) {
      return;
    }
    await GetIt.I<UserRepository>()
        .followUser(uid: state.value!.uid, value: value);
    state = AsyncValue.data(
        state.value?.copyWith(followedAt: value ? DateTime.now() : null));
  }

  Future<void> blockUser(bool value) async {
    if (state.value?.uid == null) {
      return;
    }
    await GetIt.I<UserRepository>()
        .blockUser(uid: state.value!.uid, value: value);
    state = AsyncValue.data(
        state.value?.copyWith(blockedAt: value ? DateTime.now() : null));
  }
}
