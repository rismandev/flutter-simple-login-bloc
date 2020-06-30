import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth.bloc.dart';
import 'package:flutter_login/bloc/auth.event.dart';
import 'package:flutter_login/bloc/auth.state.dart';
import 'package:flutter_login/repository/user.repository.dart';
import 'package:flutter_login/views/home.view.dart';
import 'package:flutter_login/views/login.view.dart';
import 'package:flutter_login/views/splash.view.dart';

class MainAppDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = MainAppDelegate();
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted());
    },
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Bloc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashView();
          }

          if (state is AuthenticationSuccess) {
            return HomeView();
          }

          if (state is AuthenticationFailure) {
            return LoginView(userRepository: userRepository);
          }

          if (state is AuthenticationInProgress) {
            return LoadingView();
          }
        },
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
