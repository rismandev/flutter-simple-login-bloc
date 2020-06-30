import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/login.bloc.dart';
import 'package:flutter_login/bloc/login.event.dart';
import 'package:flutter_login/bloc/login.state.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.error}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: state is! LoginInProgress
                        ? _onLoginButtonPressed
                        : null,
                    child: Text('Login'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: state is LoginInProgress
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
