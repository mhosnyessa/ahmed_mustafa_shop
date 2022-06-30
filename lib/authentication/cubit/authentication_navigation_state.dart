part of 'authentication_navigation_cubit.dart';

abstract class AuthenticationNavigationState extends Equatable {
  const AuthenticationNavigationState();

  @override
  List<Object> get props => [];
}

class AuthenticationNavigationInitial extends AuthenticationNavigationState {}

class AuthenticationNavigationSignIn extends AuthenticationNavigationState {}

class AuthenticationNavigationSignUp extends AuthenticationNavigationState {}
