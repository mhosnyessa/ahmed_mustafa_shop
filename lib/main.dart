import 'package:ahmed_mustafa_amazon/authentication/view/signup_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: MaterialApp(
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, AuthenticationState state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                // return Home();
                break;
              case AuthenticationStatus.unknown:
                return SignupPage();
                break;
              case AuthenticationStatus.initialUnauthenticated:
                return SignupPage();
                break;
              case AuthenticationStatus.unauthenticated:
                return SignupPage();
                break;
            }
          }),
        ),
      ),
    );
  }
}

  //   return MaterialApp(
  //     home: SignupPage(),
  //   );
  // }