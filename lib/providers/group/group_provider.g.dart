// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupNotifierHash() => r'306f3647a42f276d4f67523569281301d2582bdd';

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

abstract class _$GroupNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Group?> {
  late final String groupId;

  FutureOr<Group?> build(
    String groupId,
  );
}

/// See also [GroupNotifier].
@ProviderFor(GroupNotifier)
const groupNotifierProvider = GroupNotifierFamily();

/// See also [GroupNotifier].
class GroupNotifierFamily extends Family<AsyncValue<Group?>> {
  /// See also [GroupNotifier].
  const GroupNotifierFamily();

  /// See also [GroupNotifier].
  GroupNotifierProvider call(
    String groupId,
  ) {
    return GroupNotifierProvider(
      groupId,
    );
  }

  @override
  GroupNotifierProvider getProviderOverride(
    covariant GroupNotifierProvider provider,
  ) {
    return call(
      provider.groupId,
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
  String? get name => r'groupNotifierProvider';
}

/// See also [GroupNotifier].
class GroupNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GroupNotifier, Group?> {
  /// See also [GroupNotifier].
  GroupNotifierProvider(
    String groupId,
  ) : this._internal(
          () => GroupNotifier()..groupId = groupId,
          from: groupNotifierProvider,
          name: r'groupNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupNotifierHash,
          dependencies: GroupNotifierFamily._dependencies,
          allTransitiveDependencies:
              GroupNotifierFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  GroupNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  FutureOr<Group?> runNotifierBuild(
    covariant GroupNotifier notifier,
  ) {
    return notifier.build(
      groupId,
    );
  }

  @override
  Override overrideWith(GroupNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GroupNotifierProvider._internal(
        () => create()..groupId = groupId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GroupNotifier, Group?>
      createElement() {
    return _GroupNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupNotifierProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GroupNotifierRef on AutoDisposeAsyncNotifierProviderRef<Group?> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GroupNotifier, Group?>
    with GroupNotifierRef {
  _GroupNotifierProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupNotifierProvider).groupId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
