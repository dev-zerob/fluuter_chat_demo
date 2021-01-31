import 'package:chat_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:chat_demo/blocs/home_bloc/home_bloc.dart';
import 'package:chat_demo/blocs/simple_bloc_observer.dart';
import 'package:chat_demo/locator.dart';
import 'package:chat_demo/screen/home_screen.dart';
import 'package:chat_demo/screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  setupLocator();

  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(AuthenticationStarted()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      theme: ThemeData(
        primaryColor: Color(0xfffae7e9),
        accentColor: Color(0xfff2cbd0),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.transparent,
        )
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen();
          }

          if (state is AuthenticationSuccess) {
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: HomeScreen(member: state.member),
            );
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
