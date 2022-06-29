import 'package:ahmed_mustafa_amazon/authentication/view/signup_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'home/view/home.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
                return Home();
                // return SignupPage();
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
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 232, 232, 232),
          ),
        ),
      ),
    );
  }
}

  //   return MaterialApp(
  //     home: SignupPage(),
  //   );
  // }