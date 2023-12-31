// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayer/constants/bible_books.dart';

part 'bible_verse_model.freezed.dart';
part 'bible_verse_model.g.dart';

@freezed
class BibleTranslation with _$BibleTranslation {
  const factory BibleTranslation({
    required int id,
    required String lang,
    required String abbreviation,
    required String name,
  }) = _BibleTranslation;

  static BibleTranslation get KJV => BibleTranslation(
      id: 1, lang: 'en', abbreviation: 'KJV', name: 'King James Version');

  static BibleTranslation get KRV =>
      BibleTranslation(id: 2, lang: 'ko', abbreviation: 'KRV', name: '개역한글');

  static List<BibleTranslation> get values =>
      [BibleTranslation.KJV, BibleTranslation.KRV];

  static BibleTranslation? fromId(int id) {
    return switch (id) {
      1 => BibleTranslation.KJV,
      2 => BibleTranslation.KRV,
      _ => null,
    };
  }

  static BibleTranslation preference() {
    final pref = Hive.box('settings').get('bible_translations.preference');
    if (pref == null) {
      return BibleTranslation.KJV;
    }
    return BibleTranslation.fromId(pref) ?? BibleTranslation.KJV;
  }

  factory BibleTranslation.fromJson(Map<String, Object?> json) =>
      _$BibleTranslationFromJson(json);
}

@freezed
class BibleVerse with _$BibleVerse {
  const factory BibleVerse({
    required int id,
    required BibleBook book,
    required int chapter,
    required int verse,
    @JsonKey(name: 'verse_id') int? verseId,
    @JsonKey(name: 'translation_id') int? translationId,
    BibleTranslation? translation,
    String? value,
  }) = _BibleVerse;

  factory BibleVerse.fromJson(Map<String, Object?> json) =>
      _$BibleVerseFromJson(json);
}
