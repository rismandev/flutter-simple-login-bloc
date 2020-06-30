import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/bloc/auth.bloc.dart';
import 'package:flutter_login/bloc/auth.event.dart';
import 'package:flutter_login/bloc/login.event.dart';
import 'package:flutter_login/bloc/login.state.dart';
import 'package:flutter_login/repository/user.repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  }) : assert(userRepository != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield LoginInitial();
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
