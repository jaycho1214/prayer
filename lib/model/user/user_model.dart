// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/model/placeholder.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class PUser with _$PUser {
  const PUser._();

  const factory PUser({
    required String uid,
    String? email,
    required String username,
    required String name,
    String? bio,
    String? profile,
    String? banner,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'followed_at') DateTime? followedAt,
    @JsonKey(name: 'banned_at') DateTime? bannedAt,
    @JsonKey(name: 'blocked_at') DateTime? blockedAt,
    @JsonKey(name: 'verse_id') int? verseId,
    @Default(0) @JsonKey(name: 'followings_count') int followingsCount,
    @Default(0) @JsonKey(name: 'followers_count') int followersCount,
    @Default(0) @JsonKey(name: 'prayers_count') int prayersCount,
    @Default(0) @JsonKey(name: 'prays_count') int praysCount,
  }) = _PUser;

  static PUser get placeholder => PUser(
        uid: '',
        email: "test@gmail.com",
        username: "placeholder",
        name: "Placeholder",
        bio: LoremIpsum,
      );

  factory PUser.fromJson(Map<String, Object?> json) => _$PUserFromJson(json);
}
