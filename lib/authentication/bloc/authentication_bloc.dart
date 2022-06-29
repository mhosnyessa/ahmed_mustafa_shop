import 'dart:async';

import 'package:ahmed_mustafa_amazon/authentication/authentication.dart';
import 'package:ahmed_mustafa_amazon/authentication/view/signup_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationEmailChanged>(_onAuthenticationEmailChanged);
    on<AuthenticationPasswordChanged>(_onAuthenticationPasswordChanged);
    on<AuthenticationSignUpPressed>(_onAuthenticationSignUpPressed);
    on<AuthenticationLogoutPressed>(_onAuthenticationLogoutPressed);
    on<AuthenticationLogInPressed>(_onAuthenticationLogInPressed);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) {
        print('auth bloc confirmed $status');
        add(AuthenticationStatusChanged(status));
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  String? email;
  String? password;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.authenticated(User(id: '')));
      case AuthenticationStatus.initialUnauthenticated:
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticatedBySignup(user)
            : const AuthenticationState.unauthenticated());
      default:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  void emailChanged(String v) {}

  FutureOr<void> _onAuthenticationEmailChanged(
      AuthenticationEmailChanged event, Emitter<AuthenticationState> emit) {
    email = event.email;
  }

  FutureOr<void> _onAuthenticationPasswordChanged(
      AuthenticationPasswordChanged event, Emitter<AuthenticationState> emit) {
    password = event.password;
  }

  FutureOr<void> _onAuthenticationSignUpPressed(
      AuthenticationSignUpPressed event, Emitter<AuthenticationState> emit) {
    print(email);
    print(password);
    _authenticationRepository.signup(
        fullname: '',
        email: email ?? '',
        username: '',
        password: password ?? '',
        repeatPassword: password ?? '');
  }

  FutureOr<void> _onAuthenticationLogInPressed(AuthenticationLogInPressed event,
      Emitter<AuthenticationState> emit) async {
    AuthenticationStatus status = await _authenticationRepository.logIn(
        email: email ?? '', password: password ?? '');

    if (status ==
        AuthenticationState.authenticated(
          User(
            id: '',
          ),
        )) {}
  }
}
