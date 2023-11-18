import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prayer/bloc/auth/authentication_bloc.dart';

part 'authentication_event.freezed.dart';

@freezed
sealed class AuthenticationEvent with _$AuthenticationEvent {
  factory AuthenticationEvent.signIn(AuthenticationProvider provider) =
      AuthenticationEventSignIn;
  factory AuthenticationEvent.signUp({
    required String username,
    required String name,
    String? bio,
    String? profile,
    String? banner,
  }) = AuthenticationEventSignUp;
  const factory AuthenticationEvent.signOut() = AuthenticationEventSignOut;
  const factory AuthenticationEvent.refresh() = AuthenticationEventRefresh;
}
