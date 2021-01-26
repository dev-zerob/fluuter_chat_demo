import 'package:chat_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:chat_demo/blocs/authentication_bloc/authentication_event.dart';
import 'package:chat_demo/blocs/authentication_bloc/authentication_state.dart';
import 'package:chat_demo/blocs/simple_bloc_observer.dart';
import 'package:chat_demo/repositories/user_repository.dart';
import 'package:chat_demo/screen/home_screen.dart';
import 'package:chat_demo/screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AuthenticationStarted()),
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      theme: ThemeData(
        primaryColor: Color(0xff6a515e),
        cursorColor: Color(0xff6a515e),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen();
          }

          if (state is AuthenticationSuccess) {
            return HomeScreen();
          }

          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(
                child: Text(
                  "Loading",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
