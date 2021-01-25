import 'package:chat_demo/screen/register/register_screen.dart';
import 'package:chat_demo/widget/gradient_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.always,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            obscureText: true,
            autovalidateMode: AutovalidateMode.always,
          ),
          SizedBox(
            height: 10.0,
          ),
          GradientButton(
            width: 150.0,
            height: 45.0,
            onPressed: () {},
            text: Text(
              'LogIn',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.0,),
          GradientButton(
            width: 150.0,
            height: 45.0,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_){
                return RegisterScreen();
              }));
            },
            text: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
