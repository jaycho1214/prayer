// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_graph_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$openGrpahNotifierHash() => r'5d17eb361dfa4a4d635453e093dac9fbbefce1af';

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

abstract class _$OpenGrpahNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, dynamic>?> {
  late final String? url;

  FutureOr<Map<String, dynamic>?> build(
    String? url,
  );
}

/// See also [OpenGrpahNotifier].
@ProviderFor(OpenGrpahNotifier)
const openGrpahNotifierProvider = OpenGrpahNotifierFamily();

/// See also [OpenGrpahNotifier].
class OpenGrpahNotifierFamily
    extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [OpenGrpahNotifier].
  const OpenGrpahNotifierFamily();

  /// See also [OpenGrpahNotifier].
  OpenGrpahNotifierProvider call(
    String? url,
  ) {
    return OpenGrpahNotifierProvider(
      url,
    );
  }

  @override
  OpenGrpahNotifierProvider getProviderOverride(
    covariant OpenGrpahNotifierProvider provider,
  ) {
    return call(
      provider.url,
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
  String? get name => r'openGrpahNotifierProvider';
}

/// See also [OpenGrpahNotifier].
class OpenGrpahNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OpenGrpahNotifier, Map<String, dynamic>?> {
  /// See also [OpenGrpahNotifier].
  OpenGrpahNotifierProvider(
    String? url,
  ) : this._internal(
          () => OpenGrpahNotifier()..url = url,
          from: openGrpahNotifierProvider,
          name: r'openGrpahNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$openGrpahNotifierHash,
          dependencies: OpenGrpahNotifierFamily._dependencies,
          allTransitiveDependencies:
              OpenGrpahNotifierFamily._allTransitiveDependencies,
          url: url,
        );

  OpenGrpahNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String? url;

  @override
  FutureOr<Map<String, dynamic>?> runNotifierBuild(
    covariant OpenGrpahNotifier notifier,
  ) {
    return notifier.build(
      url,
    );
  }

  @override
  Override overrideWith(OpenGrpahNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: OpenGrpahNotifierProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OpenGrpahNotifier,
      Map<String, dynamic>?> createElement() {
    return _OpenGrpahNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpenGrpahNotifierProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OpenGrpahNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, dynamic>?> {
  /// The parameter `url` of this provider.
  String? get url;
}

class _OpenGrpahNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OpenGrpahNotifier,
        Map<String, dynamic>?> with OpenGrpahNotifierRef {
  _OpenGrpahNotifierProviderElement(super.provider);

  @override
  String? get url => (origin as OpenGrpahNotifierProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
