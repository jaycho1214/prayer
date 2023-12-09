import 'package:get_it/get_it.dart';
import 'package:prayer/model/bible_verse/bible_verse_model.dart';
import 'package:prayer/repo/bible_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
      Sentry.captureException(error, stackTrace: stackTrace);
      return null;
    }
  }
}
