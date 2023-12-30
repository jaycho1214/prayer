import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/corporate_prayer/models/corporate_prayer/corporate_prayer_model.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'corporate_prayer_provider.g.dart';

@riverpod
Future<CorporatePrayer?> corporatePrayer(
    CorporatePrayerRef ref, String prayerId) async {
  try {
    final data =
        await GetIt.I<PrayerRepository>().fetchCorporatePrayer(prayerId);
    return data;
  } catch (e, st) {
    talker.handle(
      e,
      st,
      generateLogMessage("[CorporatePrayer] Failed to fetch corporate prayer",
          data: {
            'prayerId': prayerId,
          }),
    );
    return null;
  }
}
