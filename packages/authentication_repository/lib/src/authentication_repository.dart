import 'dart:async';

import 'dart:io';

import './network_service.dart';
import './shared_pref_service.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  initialUnauthenticated,
  unauthenticated
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final NetworkService _networkService = NetworkService();
  final prefs = SharedPreferencesService();

  Map get authObj {
    return _networkService.returnedObj;
  }

  Stream<AuthenticationStatus> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    await prefs.initiatePrefs();
    if (await prefs.retrieveAuthValue() == true) {
      yield AuthenticationStatus.authenticated;
    } else
      yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<AuthenticationStatus> logIn({
    required String username,
    required String password,
  }) async {
    // await Future.delayed(
    //   const Duration(milliseconds: 300),
    //   () => _controller.add(AuthenticationStatus.authenticated),
    // );
    AuthenticationStatus authenticationStatus =
        await _networkService.userLoginRequest(username, password);
    _controller.add(authenticationStatus);
    await prefs.saveAuthValue(
        authenticationStatus == AuthenticationStatus.authenticated
            ? true
            : false);
    return authenticationStatus;
  }

  Future<AuthenticationStatus> signup({
    required String fullname,
    required String email,
    required String username,
    required String password,
    required String repeatPassword,
  }) async {
    AuthenticationStatus authenticationStatus =
        await _networkService.userSignupRequest(
            fullname: fullname,
            email: email,
            username: username,
            password: password,
            repeatPassword: repeatPassword);
    _controller.add(authenticationStatus);
    await prefs.saveAuthValue(
        authenticationStatus == AuthenticationStatus.authenticated);
    return authenticationStatus;
  }

  void logOut() async {
    _controller.add(AuthenticationStatus.unauthenticated);
    await prefs.saveAuthValue(false);
  }

  void dispose() => _controller.close();
}
