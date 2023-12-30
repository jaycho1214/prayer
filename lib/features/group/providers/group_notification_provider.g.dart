// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupNotificationNotifierHash() =>
    r'fbaff293f0f23f4b6957f71715d5bdaf2adfaec6';

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

abstract class _$GroupNotificationNotifier
    extends BuildlessAutoDisposeAsyncNotifier<GroupNotificationSettings> {
  late final String groupId;

  FutureOr<GroupNotificationSettings> build(
    String groupId,
  );
}

/// See also [GroupNotificationNotifier].
@ProviderFor(GroupNotificationNotifier)
const groupNotificationNotifierProvider = GroupNotificationNotifierFamily();

/// See also [GroupNotificationNotifier].
class GroupNotificationNotifierFamily
    extends Family<AsyncValue<GroupNotificationSettings>> {
  /// See also [GroupNotificationNotifier].
  const GroupNotificationNotifierFamily();

  /// See also [GroupNotificationNotifier].
  GroupNotificationNotifierProvider call(
    String groupId,
  ) {
    return GroupNotificationNotifierProvider(
      groupId,
    );
  }

  @override
  GroupNotificationNotifierProvider getProviderOverride(
    covariant GroupNotificationNotifierProvider provider,
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
  String? get name => r'groupNotificationNotifierProvider';
}

/// See also [GroupNotificationNotifier].
class GroupNotificationNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GroupNotificationNotifier,
        GroupNotificationSettings> {
  /// See also [GroupNotificationNotifier].
  GroupNotificationNotifierProvider(
    String groupId,
  ) : this._internal(
          () => GroupNotificationNotifier()..groupId = groupId,
          from: groupNotificationNotifierProvider,
          name: r'groupNotificationNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupNotificationNotifierHash,
          dependencies: GroupNotificationNotifierFamily._dependencies,
          allTransitiveDependencies:
              GroupNotificationNotifierFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  GroupNotificationNotifierProvider._internal(
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
  FutureOr<GroupNotificationSettings> runNotifierBuild(
    covariant GroupNotificationNotifier notifier,
  ) {
    return notifier.build(
      groupId,
    );
  }

  @override
  Override overrideWith(GroupNotificationNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GroupNotificationNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GroupNotificationNotifier,
      GroupNotificationSettings> createElement() {
    return _GroupNotificationNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupNotificationNotifierProvider &&
        other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GroupNotificationNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<GroupNotificationSettings> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupNotificationNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GroupNotificationNotifier,
        GroupNotificationSettings> with GroupNotificationNotifierRef {
  _GroupNotificationNotifierProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupNotificationNotifierProvider).groupId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
