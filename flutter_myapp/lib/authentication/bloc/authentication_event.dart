part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class AuthenticationLoginRequested extends AuthenticationEvent {
  const AuthenticationLoginRequested(this.password);

  final String password;
}
