import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';
import 'package:prayer/model/user_model.dart';

part 'authentication_state.freezed.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.idle() = AuthenticationStateIdle;
  factory AuthenticationState.signInLoading(AuthenticationProvider provider) =
      AuthenticationStateSignInLoading;
  const factory AuthenticationState.signInError() =
      AuthenticationStateSignInError;
  const factory AuthenticationState.signedIn() = AuthenticationStateSignedIn;
  const factory AuthenticationState.signedUp(PUser user) =
      AuthenticationStateSignedUp;
  const factory AuthenticationState.signUpError(String message) =
      AuthenticationStateSignUpError;
  factory AuthenticationState.signUpLoading() =
      AuthenticationStateSignUpLoading;
}
