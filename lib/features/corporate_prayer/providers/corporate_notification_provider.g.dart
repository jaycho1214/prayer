// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$corporateNotificationNotifierHash() =>
    r'2467002756627a91cb6bb8c84f221265dd8b99e4';

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

abstract class _$CorporateNotificationNotifier
    extends BuildlessAutoDisposeAsyncNotifier<
        CorporatePrayerNotificationSettings> {
  late final String corporateId;

  FutureOr<CorporatePrayerNotificationSettings> build(
    String corporateId,
  );
}

/// See also [CorporateNotificationNotifier].
@ProviderFor(CorporateNotificationNotifier)
const corporateNotificationNotifierProvider =
    CorporateNotificationNotifierFamily();

/// See also [CorporateNotificationNotifier].
class CorporateNotificationNotifierFamily
    extends Family<AsyncValue<CorporatePrayerNotificationSettings>> {
  /// See also [CorporateNotificationNotifier].
  const CorporateNotificationNotifierFamily();

  /// See also [CorporateNotificationNotifier].
  CorporateNotificationNotifierProvider call(
    String corporateId,
  ) {
    return CorporateNotificationNotifierProvider(
      corporateId,
    );
  }

  @override
  CorporateNotificationNotifierProvider getProviderOverride(
    covariant CorporateNotificationNotifierProvider provider,
  ) {
    return call(
      provider.corporateId,
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
  String? get name => r'corporateNotificationNotifierProvider';
}

/// See also [CorporateNotificationNotifier].
class CorporateNotificationNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CorporateNotificationNotifier,
        CorporatePrayerNotificationSettings> {
  /// See also [CorporateNotificationNotifier].
  CorporateNotificationNotifierProvider(
    String corporateId,
  ) : this._internal(
          () => CorporateNotificationNotifier()..corporateId = corporateId,
          from: corporateNotificationNotifierProvider,
          name: r'corporateNotificationNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$corporateNotificationNotifierHash,
          dependencies: CorporateNotificationNotifierFamily._dependencies,
          allTransitiveDependencies:
              CorporateNotificationNotifierFamily._allTransitiveDependencies,
          corporateId: corporateId,
        );

  CorporateNotificationNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.corporateId,
  }) : super.internal();

  final String corporateId;

  @override
  FutureOr<CorporatePrayerNotificationSettings> runNotifierBuild(
    covariant CorporateNotificationNotifier notifier,
  ) {
    return notifier.build(
      corporateId,
    );
  }

  @override
  Override overrideWith(CorporateNotificationNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CorporateNotificationNotifierProvider._internal(
        () => create()..corporateId = corporateId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        corporateId: corporateId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CorporateNotificationNotifier,
      CorporatePrayerNotificationSettings> createElement() {
    return _CorporateNotificationNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CorporateNotificationNotifierProvider &&
        other.corporateId == corporateId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, corporateId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CorporateNotificationNotifierRef on AutoDisposeAsyncNotifierProviderRef<
    CorporatePrayerNotificationSettings> {
  /// The parameter `corporateId` of this provider.
  String get corporateId;
}

class _CorporateNotificationNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        CorporateNotificationNotifier, CorporatePrayerNotificationSettings>
    with CorporateNotificationNotifierRef {
  _CorporateNotificationNotifierProviderElement(super.provider);

  @override
  String get corporateId =>
      (origin as CorporateNotificationNotifierProvider).corporateId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
