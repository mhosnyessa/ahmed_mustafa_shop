import 'package:ahmed_mustafa_amazon/authentication/view/authentication_screen.dart';
import 'package:ahmed_mustafa_amazon/authentication/view/signup_screen.dart';
import 'package:ahmed_mustafa_amazon/upload/bloc/upload_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';
import 'package:products_repository/products_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'home/bloc/products_bloc.dart';
import 'home/view/home_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
    productsRepository: ProductsRepository(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.productsRepository,
  }) : super(key: key);
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final ProductsRepository productsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ProductsBloc(
              productsRepository: productsRepository,
            ),
          ),
          BlocProvider(
            create: (context) =>
                UploadBloc(productsRepository: productsRepository),
          )
        ],
        child: MaterialApp(
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, AuthenticationState state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                return HomeScreen();
                // return SignupPage();
                break;
              case AuthenticationStatus.unknown:
                return AuthenticationScreen();
                break;
              case AuthenticationStatus.initialUnauthenticated:
                return AuthenticationScreen();
                break;
              case AuthenticationStatus.unauthenticated:
                return AuthenticationScreen();
                break;
            }
          }),
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 65, 74, 76),
            primarySwatch: Colors.cyan,
          ),
        ),
      ),
    );
  }
}
