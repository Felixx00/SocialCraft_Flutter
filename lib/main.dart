import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'perfil.dart';
import 'forgotPassword.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      'login': (BuildContext context) => Login(),
      'register': (BuildContext context) => Register(),
      'perfil': (BuildContext context) => Perfil(),
      'forgotPassword': (BuildContext context) => ForgotPassword(),
    }, debugShowCheckedModeBanner: false, home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(100.0),
        child: Wrap(
          children: <Widget>[
            OutlinedButton(
              child: Text("Login"),
              onPressed: () => Navigator.pushNamed(context, "login"),
            ),
            OutlinedButton(
              child: Text("Register"),
              onPressed: () => Navigator.pushNamed(context, "register"),
            ),
            OutlinedButton(
              child: Text("Perfil"),
              onPressed: () => Navigator.pushNamed(context, "perfil"),
            ),
          ],
        )
        // ignore: unnecessary_statements

        );
  }
}
