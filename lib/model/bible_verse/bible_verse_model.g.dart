// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_verse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BibleTranslationImpl _$$BibleTranslationImplFromJson(
        Map<String, dynamic> json) =>
    _$BibleTranslationImpl(
      id: json['id'] as int,
      lang: json['lang'] as String,
      abbreviation: json['abbreviation'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$BibleTranslationImplToJson(
        _$BibleTranslationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lang': instance.lang,
      'abbreviation': instance.abbreviation,
      'name': instance.name,
    };

_$BibleVerseImpl _$$BibleVerseImplFromJson(Map<String, dynamic> json) =>
    _$BibleVerseImpl(
      id: json['id'] as int,
      book: $enumDecode(_$BibleBookEnumMap, json['book']),
      chapter: json['chapter'] as int,
      verse: json['verse'] as int,
      verseId: json['verse_id'] as int?,
      translationId: json['translation_id'] as int?,
      translation: json['translation'] == null
          ? null
          : BibleTranslation.fromJson(
              json['translation'] as Map<String, dynamic>),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$BibleVerseImplToJson(_$BibleVerseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book': _$BibleBookEnumMap[instance.book]!,
      'chapter': instance.chapter,
      'verse': instance.verse,
      'verse_id': instance.verseId,
      'translation_id': instance.translationId,
      'translation': instance.translation,
      'value': instance.value,
    };

const _$BibleBookEnumMap = {
  BibleBook.genesis: 'genesis',
  BibleBook.exodus: 'exodus',
  BibleBook.leviticus: 'leviticus',
  BibleBook.numbers: 'numbers',
  BibleBook.deuteronomy: 'deuteronomy',
  BibleBook.joshua: 'joshua',
  BibleBook.judges: 'judges',
  BibleBook.ruth: 'ruth',
  BibleBook.firstSamuel: 'firstSamuel',
  BibleBook.secondSamuel: 'secondSamuel',
  BibleBook.firstKings: 'firstKings',
  BibleBook.secondKings: 'secondKings',
  BibleBook.firstChronicles: 'firstChronicles',
  BibleBook.secondChronicles: 'secondChronicles',
  BibleBook.ezra: 'ezra',
  BibleBook.nehemiah: 'nehemiah',
  BibleBook.esther: 'esther',
  BibleBook.job: 'job',
  BibleBook.psalms: 'psalms',
  BibleBook.proverbs: 'proverbs',
  BibleBook.ecclesiastes: 'ecclesiastes',
  BibleBook.songOfSongs: 'songOfSongs',
  BibleBook.isaiah: 'isaiah',
  BibleBook.jeremiah: 'jeremiah',
  BibleBook.lamentations: 'lamentations',
  BibleBook.ezekiel: 'ezekiel',
  BibleBook.daniel: 'daniel',
  BibleBook.hosea: 'hosea',
  BibleBook.joel: 'joel',
  BibleBook.amos: 'amos',
  BibleBook.obadiah: 'obadiah',
  BibleBook.jonah: 'jonah',
  BibleBook.micah: 'micah',
  BibleBook.nahum: 'nahum',
  BibleBook.habakkuk: 'habakkuk',
  BibleBook.zephaniah: 'zephaniah',
  BibleBook.haggai: 'haggai',
  BibleBook.zechariah: 'zechariah',
  BibleBook.malachi: 'malachi',
  BibleBook.matthew: 'matthew',
  BibleBook.mark: 'mark',
  BibleBook.luke: 'luke',
  BibleBook.john: 'john',
  BibleBook.acts: 'acts',
  BibleBook.romans: 'romans',
  BibleBook.firstCorinthians: 'firstCorinthians',
  BibleBook.secondCorinthians: 'secondCorinthians',
  BibleBook.galatians: 'galatians',
  BibleBook.ephesians: 'ephesians',
  BibleBook.philippians: 'philippians',
  BibleBook.colossians: 'colossians',
  BibleBook.firstThessalonians: 'firstThessalonians',
  BibleBook.secondThessalonians: 'secondThessalonians',
  BibleBook.firstTimothy: 'firstTimothy',
  BibleBook.secondTimothy: 'secondTimothy',
  BibleBook.titus: 'titus',
  BibleBook.philemon: 'philemon',
  BibleBook.hebrews: 'hebrews',
  BibleBook.james: 'james',
  BibleBook.firstPeter: 'firstPeter',
  BibleBook.secondPeter: 'secondPeter',
  BibleBook.firstJohn: 'firstJohn',
  BibleBook.secondJohn: 'secondJohn',
  BibleBook.thirdJohn: 'thirdJohn',
  BibleBook.jude: 'jude',
  BibleBook.revelation: 'revelation',
};
