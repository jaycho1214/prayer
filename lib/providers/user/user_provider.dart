import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/user/user_model.dart';
import 'package:prayer/providers/auth/auth_provider.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<PUser?> user(UserRef ref, {String? uid, String? username}) async {
  try {
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
