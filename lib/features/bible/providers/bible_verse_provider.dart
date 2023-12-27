import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/repo/bible_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_verse_provider.g.dart';

@riverpod
class BibleVerseNotifier extends _$BibleVerseNotifier {
  @override
  FutureOr<BibleVerse?> build(int verseId, {int? translationId}) async {
    try {
      final data = await GetIt.I<BibleRepository>()
          .fetchVerse(verseId, translationId: translationId);
      return data;
    } catch (error, stackTrace) {
      talker.handle(
          error,
          stackTrace,
          generateLogMessage("[BibleVerse] Failed to fetch", data: {
            'verseId': verseId,
            'translationId': translationId,
          }));
      return null;
    }
  }
}
