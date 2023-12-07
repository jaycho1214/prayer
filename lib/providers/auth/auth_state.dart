import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/model/user/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.signedOut() = AuthStateSignedOut;
  const factory AuthState.signedIn() = AuthStateSignedIn;
  const factory AuthState.signedUp(PUser user) = AuthStateSignedUp;
}
