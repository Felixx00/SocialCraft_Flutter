import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'perfil.dart';
import 'forgotPassword.dart';
import 'editar.dart';
import 'password.dart';
import 'settings.dart';
import 'transition.dart';

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
      'editar': (BuildContext context) => Editar(),
      'password': (BuildContext context) => Password(),
      'settings': (BuildContext context) => Settings(),
      'transition': (BuildContext context) => Transition(),
    }, debugShowCheckedModeBanner: false, home: Transition());
  }
}
