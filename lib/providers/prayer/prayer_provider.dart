import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/prayer_model.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:synchronized/synchronized.dart';

part 'prayer_provider.g.dart';

final prayerNotifierLock = new Lock();

@riverpod
class PrayerNotifier extends _$PrayerNotifier {
  @override
  FutureOr<Prayer?> build(String prayerId) async {
    try {
      final data = await GetIt.I<PrayerRepository>().fetchPrayer(prayerId);
      return data;
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      return null;
    }
  }

  void prayForUser({
    String? value,
    void Function()? onError,
    void Function()? onNeedWait,
  }) async {
    await prayerNotifierLock.synchronized(() async {
      final backup = state.value;
      state = AsyncValue.data(state.value?.copyWith(
        praysCount: (state.value?.praysCount ?? 0) + 1,
        hasPrayed: DateTime.now(),
      ));
      try {
        final resp = await GetIt.I<PrayerRepository>().createPrayerPray(
          prayerId: prayerId,
          value: value,
        );
        if (!resp) {
          state = AsyncValue.data(backup);
          onNeedWait?.call();
        }
      } catch (error, stackTrace) {
        Sentry.captureException(error, stackTrace: stackTrace);
        talker.error("Error while praying for the post", error);
        onError?.call();
      }
    });
  }
}
