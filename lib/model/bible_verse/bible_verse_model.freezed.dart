// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bible_verse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BibleTranslation _$BibleTranslationFromJson(Map<String, dynamic> json) {
  return _BibleTranslation.fromJson(json);
}

/// @nodoc
mixin _$BibleTranslation {
  int get id => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;
  String get abbreviation => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BibleTranslationCopyWith<BibleTranslation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BibleTranslationCopyWith<$Res> {
  factory $BibleTranslationCopyWith(
          BibleTranslation value, $Res Function(BibleTranslation) then) =
      _$BibleTranslationCopyWithImpl<$Res, BibleTranslation>;
  @useResult
  $Res call({int id, String lang, String abbreviation, String name});
}

/// @nodoc
class _$BibleTranslationCopyWithImpl<$Res, $Val extends BibleTranslation>
    implements $BibleTranslationCopyWith<$Res> {
  _$BibleTranslationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lang = null,
    Object? abbreviation = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      abbreviation: null == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BibleTranslationImplCopyWith<$Res>
    implements $BibleTranslationCopyWith<$Res> {
  factory _$$BibleTranslationImplCopyWith(_$BibleTranslationImpl value,
          $Res Function(_$BibleTranslationImpl) then) =
      __$$BibleTranslationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String lang, String abbreviation, String name});
}

/// @nodoc
class __$$BibleTranslationImplCopyWithImpl<$Res>
    extends _$BibleTranslationCopyWithImpl<$Res, _$BibleTranslationImpl>
    implements _$$BibleTranslationImplCopyWith<$Res> {
  __$$BibleTranslationImplCopyWithImpl(_$BibleTranslationImpl _value,
      $Res Function(_$BibleTranslationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lang = null,
    Object? abbreviation = null,
    Object? name = null,
  }) {
    return _then(_$BibleTranslationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      abbreviation: null == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BibleTranslationImpl implements _BibleTranslation {
  const _$BibleTranslationImpl(
      {required this.id,
      required this.lang,
      required this.abbreviation,
      required this.name});

  factory _$BibleTranslationImpl.fromJson(Map<String, dynamic> json) =>
      _$$BibleTranslationImplFromJson(json);

  @override
  final int id;
  @override
  final String lang;
  @override
  final String abbreviation;
  @override
  final String name;

  @override
  String toString() {
    return 'BibleTranslation(id: $id, lang: $lang, abbreviation: $abbreviation, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BibleTranslationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, lang, abbreviation, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BibleTranslationImplCopyWith<_$BibleTranslationImpl> get copyWith =>
      __$$BibleTranslationImplCopyWithImpl<_$BibleTranslationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BibleTranslationImplToJson(
      this,
    );
  }
}

abstract class _BibleTranslation implements BibleTranslation {
  const factory _BibleTranslation(
      {required final int id,
      required final String lang,
      required final String abbreviation,
      required final String name}) = _$BibleTranslationImpl;

  factory _BibleTranslation.fromJson(Map<String, dynamic> json) =
      _$BibleTranslationImpl.fromJson;

  @override
  int get id;
  @override
  String get lang;
  @override
  String get abbreviation;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$BibleTranslationImplCopyWith<_$BibleTranslationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BibleVerse _$BibleVerseFromJson(Map<String, dynamic> json) {
  return _BibleVerse.fromJson(json);
}

/// @nodoc
mixin _$BibleVerse {
  int get id => throw _privateConstructorUsedError;
  BibleBook get book => throw _privateConstructorUsedError;
  int get chapter => throw _privateConstructorUsedError;
  int get verse => throw _privateConstructorUsedError;
  @JsonKey(name: 'verse_id')
  int? get verseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'translation_id')
  int? get translationId => throw _privateConstructorUsedError;
  BibleTranslation? get translation => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BibleVerseCopyWith<BibleVerse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BibleVerseCopyWith<$Res> {
  factory $BibleVerseCopyWith(
          BibleVerse value, $Res Function(BibleVerse) then) =
      _$BibleVerseCopyWithImpl<$Res, BibleVerse>;
  @useResult
  $Res call(
      {int id,
      BibleBook book,
      int chapter,
      int verse,
      @JsonKey(name: 'verse_id') int? verseId,
      @JsonKey(name: 'translation_id') int? translationId,
      BibleTranslation? translation,
      String? value});

  $BibleTranslationCopyWith<$Res>? get translation;
}

/// @nodoc
class _$BibleVerseCopyWithImpl<$Res, $Val extends BibleVerse>
    implements $BibleVerseCopyWith<$Res> {
  _$BibleVerseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? book = null,
    Object? chapter = null,
    Object? verse = null,
    Object? verseId = freezed,
    Object? translationId = freezed,
    Object? translation = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BibleBook,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as int,
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as int,
      verseId: freezed == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int?,
      translationId: freezed == translationId
          ? _value.translationId
          : translationId // ignore: cast_nullable_to_non_nullable
              as int?,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as BibleTranslation?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BibleTranslationCopyWith<$Res>? get translation {
    if (_value.translation == null) {
      return null;
    }

    return $BibleTranslationCopyWith<$Res>(_value.translation!, (value) {
      return _then(_value.copyWith(translation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BibleVerseImplCopyWith<$Res>
    implements $BibleVerseCopyWith<$Res> {
  factory _$$BibleVerseImplCopyWith(
          _$BibleVerseImpl value, $Res Function(_$BibleVerseImpl) then) =
      __$$BibleVerseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      BibleBook book,
      int chapter,
      int verse,
      @JsonKey(name: 'verse_id') int? verseId,
      @JsonKey(name: 'translation_id') int? translationId,
      BibleTranslation? translation,
      String? value});

  @override
  $BibleTranslationCopyWith<$Res>? get translation;
}

/// @nodoc
class __$$BibleVerseImplCopyWithImpl<$Res>
    extends _$BibleVerseCopyWithImpl<$Res, _$BibleVerseImpl>
    implements _$$BibleVerseImplCopyWith<$Res> {
  __$$BibleVerseImplCopyWithImpl(
      _$BibleVerseImpl _value, $Res Function(_$BibleVerseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? book = null,
    Object? chapter = null,
    Object? verse = null,
    Object? verseId = freezed,
    Object? translationId = freezed,
    Object? translation = freezed,
    Object? value = freezed,
  }) {
    return _then(_$BibleVerseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as BibleBook,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as int,
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as int,
      verseId: freezed == verseId
          ? _value.verseId
          : verseId // ignore: cast_nullable_to_non_nullable
              as int?,
      translationId: freezed == translationId
          ? _value.translationId
          : translationId // ignore: cast_nullable_to_non_nullable
              as int?,
      translation: freezed == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as BibleTranslation?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BibleVerseImpl implements _BibleVerse {
  const _$BibleVerseImpl(
      {required this.id,
      required this.book,
      required this.chapter,
      required this.verse,
      @JsonKey(name: 'verse_id') this.verseId,
      @JsonKey(name: 'translation_id') this.translationId,
      this.translation,
      this.value});

  factory _$BibleVerseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BibleVerseImplFromJson(json);

  @override
  final int id;
  @override
  final BibleBook book;
  @override
  final int chapter;
  @override
  final int verse;
  @override
  @JsonKey(name: 'verse_id')
  final int? verseId;
  @override
  @JsonKey(name: 'translation_id')
  final int? translationId;
  @override
  final BibleTranslation? translation;
  @override
  final String? value;

  @override
  String toString() {
    return 'BibleVerse(id: $id, book: $book, chapter: $chapter, verse: $verse, verseId: $verseId, translationId: $translationId, translation: $translation, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BibleVerseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.verse, verse) || other.verse == verse) &&
            (identical(other.verseId, verseId) || other.verseId == verseId) &&
            (identical(other.translationId, translationId) ||
                other.translationId == translationId) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, book, chapter, verse,
      verseId, translationId, translation, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BibleVerseImplCopyWith<_$BibleVerseImpl> get copyWith =>
      __$$BibleVerseImplCopyWithImpl<_$BibleVerseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BibleVerseImplToJson(
      this,
    );
  }
}

abstract class _BibleVerse implements BibleVerse {
  const factory _BibleVerse(
      {required final int id,
      required final BibleBook book,
      required final int chapter,
      required final int verse,
      @JsonKey(name: 'verse_id') final int? verseId,
      @JsonKey(name: 'translation_id') final int? translationId,
      final BibleTranslation? translation,
      final String? value}) = _$BibleVerseImpl;

  factory _BibleVerse.fromJson(Map<String, dynamic> json) =
      _$BibleVerseImpl.fromJson;

  @override
  int get id;
  @override
  BibleBook get book;
  @override
  int get chapter;
  @override
  int get verse;
  @override
  @JsonKey(name: 'verse_id')
  int? get verseId;
  @override
  @JsonKey(name: 'translation_id')
  int? get translationId;
  @override
  BibleTranslation? get translation;
  @override
  String? get value;
  @override
  @JsonKey(ignore: true)
  _$$BibleVerseImplCopyWith<_$BibleVerseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
