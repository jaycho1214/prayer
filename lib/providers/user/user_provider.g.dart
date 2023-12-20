// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userNotifierHash() => r'22da2c284292ac4ea4687250a9e6cdf63af5e194';

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

abstract class _$UserNotifier
    extends BuildlessAutoDisposeAsyncNotifier<PUser?> {
  late final String? uid;
  late final String? username;

  FutureOr<PUser?> build({
    String? uid,
    String? username,
  });
}

/// See also [UserNotifier].
@ProviderFor(UserNotifier)
const userNotifierProvider = UserNotifierFamily();

/// See also [UserNotifier].
class UserNotifierFamily extends Family<AsyncValue<PUser?>> {
  /// See also [UserNotifier].
  const UserNotifierFamily();

  /// See also [UserNotifier].
  UserNotifierProvider call({
    String? uid,
    String? username,
  }) {
    return UserNotifierProvider(
      uid: uid,
      username: username,
    );
  }

  @override
  UserNotifierProvider getProviderOverride(
    covariant UserNotifierProvider provider,
  ) {
    return call(
      uid: provider.uid,
      username: provider.username,
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
  String? get name => r'userNotifierProvider';
}

/// See also [UserNotifier].
class UserNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserNotifier, PUser?> {
  /// See also [UserNotifier].
  UserNotifierProvider({
    String? uid,
    String? username,
  }) : this._internal(
          () => UserNotifier()
            ..uid = uid
            ..username = username,
          from: userNotifierProvider,
          name: r'userNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userNotifierHash,
          dependencies: UserNotifierFamily._dependencies,
          allTransitiveDependencies:
              UserNotifierFamily._allTransitiveDependencies,
          uid: uid,
          username: username,
        );

  UserNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
    required this.username,
  }) : super.internal();

  final String? uid;
  final String? username;

  @override
  FutureOr<PUser?> runNotifierBuild(
    covariant UserNotifier notifier,
  ) {
    return notifier.build(
      uid: uid,
      username: username,
    );
  }

  @override
  Override overrideWith(UserNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserNotifierProvider._internal(
        () => create()
          ..uid = uid
          ..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserNotifier, PUser?>
      createElement() {
    return _UserNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserNotifierProvider &&
        other.uid == uid &&
        other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserNotifierRef on AutoDisposeAsyncNotifierProviderRef<PUser?> {
  /// The parameter `uid` of this provider.
  String? get uid;

  /// The parameter `username` of this provider.
  String? get username;
}

class _UserNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserNotifier, PUser?>
    with UserNotifierRef {
  _UserNotifierProviderElement(super.provider);

  @override
  String? get uid => (origin as UserNotifierProvider).uid;
  @override
  String? get username => (origin as UserNotifierProvider).username;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
