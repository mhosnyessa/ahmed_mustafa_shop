part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class AuthenticationEmailChanged extends AuthenticationEvent {
  const AuthenticationEmailChanged(this.email);

  final String email;
  @override
  List<Object> get props => [email];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
