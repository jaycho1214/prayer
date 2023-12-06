// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prayerNotifierHash() => r'8bdd3d3cfbf14da5d4094a748ba1bb617460bac0';

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

abstract class _$PrayerNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Prayer?> {
  late final String prayerId;

  FutureOr<Prayer?> build(
    String prayerId,
  );
}

/// See also [PrayerNotifier].
@ProviderFor(PrayerNotifier)
const prayerNotifierProvider = PrayerNotifierFamily();

/// See also [PrayerNotifier].
class PrayerNotifierFamily extends Family<AsyncValue<Prayer?>> {
  /// See also [PrayerNotifier].
  const PrayerNotifierFamily();

  /// See also [PrayerNotifier].
  PrayerNotifierProvider call(
    String prayerId,
  ) {
    return PrayerNotifierProvider(
      prayerId,
    );
  }

  @override
  PrayerNotifierProvider getProviderOverride(
    covariant PrayerNotifierProvider provider,
  ) {
    return call(
      provider.prayerId,
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
  String? get name => r'prayerNotifierProvider';
}

/// See also [PrayerNotifier].
class PrayerNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PrayerNotifier, Prayer?> {
  /// See also [PrayerNotifier].
  PrayerNotifierProvider(
    String prayerId,
  ) : this._internal(
          () => PrayerNotifier()..prayerId = prayerId,
          from: prayerNotifierProvider,
          name: r'prayerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$prayerNotifierHash,
          dependencies: PrayerNotifierFamily._dependencies,
          allTransitiveDependencies:
              PrayerNotifierFamily._allTransitiveDependencies,
          prayerId: prayerId,
        );

  PrayerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.prayerId,
  }) : super.internal();

  final String prayerId;

  @override
  FutureOr<Prayer?> runNotifierBuild(
    covariant PrayerNotifier notifier,
  ) {
    return notifier.build(
      prayerId,
    );
  }

  @override
  Override overrideWith(PrayerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PrayerNotifierProvider._internal(
        () => create()..prayerId = prayerId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        prayerId: prayerId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PrayerNotifier, Prayer?>
      createElement() {
    return _PrayerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrayerNotifierProvider && other.prayerId == prayerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, prayerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PrayerNotifierRef on AutoDisposeAsyncNotifierProviderRef<Prayer?> {
  /// The parameter `prayerId` of this provider.
  String get prayerId;
}

class _PrayerNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PrayerNotifier, Prayer?>
    with PrayerNotifierRef {
  _PrayerNotifierProviderElement(super.provider);

  @override
  String get prayerId => (origin as PrayerNotifierProvider).prayerId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
