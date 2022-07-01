import 'package:ahmed_mustafa_amazon/authentication/view/login_screen.dart';
import 'package:ahmed_mustafa_amazon/authentication/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../cubit/authentication_navigation_cubit.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationNavigationCubit>(
      create: (context) => AuthenticationNavigationCubit(),
      child: AuthenticationScreenBody(),
    );
  }
}

class AuthenticationScreenBody extends StatelessWidget {
  const AuthenticationScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationNavigationCubit,
          AuthenticationNavigationState>(
        builder: (context, state) {
          if (state is AuthenticationNavigationInitial) {
            return SignupPage();
          } else if (state is AuthenticationNavigationSignIn) {
            return LoginPage();
          } else if (state is AuthenticationNavigationSignUp) {
            return SignupPage();
          }
          // switch (state.runtimeType) {
          //   case AuthenticationNavigationSignIn:
          //     return LoginPage();
          //   case AuthenticationNavigationSignUp:
          //     return SignupPage();
          //   case AuthenticationNavigationInitial:
          //     return SignupPage();
          // }
          return const Scaffold(
            body: Center(
              child: Text('error has occurd in navigation'),
            ),
          );
        },
      ),
    );
  }
}
