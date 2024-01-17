// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_prayer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$corporatePrayerHash() => r'6b81becbde09d29cdcf7a522210ec74a18d11ac6';

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

/// See also [corporatePrayer].
@ProviderFor(corporatePrayer)
const corporatePrayerProvider = CorporatePrayerFamily();

/// See also [corporatePrayer].
class CorporatePrayerFamily extends Family<AsyncValue<CorporatePrayer?>> {
  /// See also [corporatePrayer].
  const CorporatePrayerFamily();

  /// See also [corporatePrayer].
  CorporatePrayerProvider call(
    String? prayerId,
  ) {
    return CorporatePrayerProvider(
      prayerId,
    );
  }

  @override
  CorporatePrayerProvider getProviderOverride(
    covariant CorporatePrayerProvider provider,
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
  String? get name => r'corporatePrayerProvider';
}

/// See also [corporatePrayer].
class CorporatePrayerProvider
    extends AutoDisposeFutureProvider<CorporatePrayer?> {
  /// See also [corporatePrayer].
  CorporatePrayerProvider(
    String? prayerId,
  ) : this._internal(
          (ref) => corporatePrayer(
            ref as CorporatePrayerRef,
            prayerId,
          ),
          from: corporatePrayerProvider,
          name: r'corporatePrayerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$corporatePrayerHash,
          dependencies: CorporatePrayerFamily._dependencies,
          allTransitiveDependencies:
              CorporatePrayerFamily._allTransitiveDependencies,
          prayerId: prayerId,
        );

  CorporatePrayerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.prayerId,
  }) : super.internal();

  final String? prayerId;

  @override
  Override overrideWith(
    FutureOr<CorporatePrayer?> Function(CorporatePrayerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CorporatePrayerProvider._internal(
        (ref) => create(ref as CorporatePrayerRef),
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
  AutoDisposeFutureProviderElement<CorporatePrayer?> createElement() {
    return _CorporatePrayerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CorporatePrayerProvider && other.prayerId == prayerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, prayerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CorporatePrayerRef on AutoDisposeFutureProviderRef<CorporatePrayer?> {
  /// The parameter `prayerId` of this provider.
  String? get prayerId;
}

class _CorporatePrayerProviderElement
    extends AutoDisposeFutureProviderElement<CorporatePrayer?>
    with CorporatePrayerRef {
  _CorporatePrayerProviderElement(super.provider);

  @override
  String? get prayerId => (origin as CorporatePrayerProvider).prayerId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
