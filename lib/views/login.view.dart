import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth.bloc.dart';
import 'package:flutter_login/bloc/login.bloc.dart';
import 'package:flutter_login/repository/user.repository.dart';
import 'package:flutter_login/views/login.form.dart';

class LoginView extends StatelessWidget {
  final UserRepository userRepository;

  const LoginView({
    Key key,
    @required this.userRepository,
  }) : assert(userRepository != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login App'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository);
        },
        child: LoginForm(),
      ),
    );
  }
}
