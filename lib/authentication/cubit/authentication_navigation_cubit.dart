import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_navigation_state.dart';

class AuthenticationNavigationCubit
    extends Cubit<AuthenticationNavigationState> {
  AuthenticationNavigationCubit() : super(AuthenticationNavigationInitial());

  void navigatedToSignUp() {
    print('moving to sign up from cubit');
    emit(AuthenticationNavigationSignUp());
  }

  void navigatedToSignIn() {
    print('moving to sign in from cubit');
    emit(AuthenticationNavigationSignIn());
  }
}
