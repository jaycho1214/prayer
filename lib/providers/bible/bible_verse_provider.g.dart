// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_verse_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bibleVerseNotifierHash() =>
    r'6484d73346576e85f923c8537223412b25ba3bcc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BibleVerseNotifier
    extends BuildlessAutoDisposeAsyncNotifier<BibleVerse?> {
  late final int verseId;
  late final int? translationId;

  FutureOr<BibleVerse?> build(
    int verseId, {
    int? translationId,
  });
}

/// See also [BibleVerseNotifier].
@ProviderFor(BibleVerseNotifier)
const bibleVerseNotifierProvider = BibleVerseNotifierFamily();

/// See also [BibleVerseNotifier].
class BibleVerseNotifierFamily extends Family<AsyncValue<BibleVerse?>> {
  /// See also [BibleVerseNotifier].
  const BibleVerseNotifierFamily();

  /// See also [BibleVerseNotifier].
  BibleVerseNotifierProvider call(
    int verseId, {
    int? translationId,
  }) {
    return BibleVerseNotifierProvider(
      verseId,
      translationId: translationId,
    );
  }

  @override
  BibleVerseNotifierProvider getProviderOverride(
    covariant BibleVerseNotifierProvider provider,
  ) {
    return call(
      provider.verseId,
      translationId: provider.translationId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bibleVerseNotifierProvider';
}

/// See also [BibleVerseNotifier].
class BibleVerseNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    BibleVerseNotifier, BibleVerse?> {
  /// See also [BibleVerseNotifier].
  BibleVerseNotifierProvider(
    int verseId, {
    int? translationId,
  }) : this._internal(
          () => BibleVerseNotifier()
            ..verseId = verseId
            ..translationId = translationId,
          from: bibleVerseNotifierProvider,
          name: r'bibleVerseNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bibleVerseNotifierHash,
          dependencies: BibleVerseNotifierFamily._dependencies,
          allTransitiveDependencies:
              BibleVerseNotifierFamily._allTransitiveDependencies,
          verseId: verseId,
          translationId: translationId,
        );

  BibleVerseNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.verseId,
    required this.translationId,
  }) : super.internal();

  final int verseId;
  final int? translationId;

  @override
  FutureOr<BibleVerse?> runNotifierBuild(
    covariant BibleVerseNotifier notifier,
  ) {
    return notifier.build(
      verseId,
      translationId: translationId,
    );
  }

  @override
  Override overrideWith(BibleVerseNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: BibleVerseNotifierProvider._internal(
        () => create()
          ..verseId = verseId
          ..translationId = translationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        verseId: verseId,
        translationId: translationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BibleVerseNotifier, BibleVerse?>
      createElement() {
    return _BibleVerseNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BibleVerseNotifierProvider &&
        other.verseId == verseId &&
        other.translationId == translationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, verseId.hashCode);
    hash = _SystemHash.combine(hash, translationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BibleVerseNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<BibleVerse?> {
  /// The parameter `verseId` of this provider.
  int get verseId;

  /// The parameter `translationId` of this provider.
  int? get translationId;
}

class _BibleVerseNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BibleVerseNotifier,
        BibleVerse?> with BibleVerseNotifierRef {
  _BibleVerseNotifierProviderElement(super.provider);

  @override
  int get verseId => (origin as BibleVerseNotifierProvider).verseId;
  @override
  int? get translationId =>
      (origin as BibleVerseNotifierProvider).translationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
