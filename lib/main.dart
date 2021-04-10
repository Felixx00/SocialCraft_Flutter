import 'package:flutter/material.dart';
import 'buscar.dart';
import 'perfil2.dart';
import 'login.dart';
import 'register.dart';
import 'perfil.dart';
import 'barraNavegacion.dart';
import 'forgotPassword.dart';
import 'editar.dart';
import 'password.dart';
import 'settings.dart';
import 'transition.dart';
import 'post.dart';
import 'upload.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          'login': (BuildContext context) => Login(),
          'register': (BuildContext context) => Register(),
          'barra': (BuildContext context) => barra(),
          'perfil': (BuildContext context) => Perfil(),
          'perfil2': (BuildContext context) => Perfil2(),
          'forgotPassword': (BuildContext context) => ForgotPassword(),
          'editar': (BuildContext context) => Editar(),
          'search': (BuildContext context) => Search(),
          'password': (BuildContext context) => Password(),
          'settings': (BuildContext context) => Settings(),
          'transition': (BuildContext context) => Transition(),
          'post': (BuildContext context) => Post(),
          'upload': (BuildContext context) => Upload(),
        },
        debugShowCheckedModeBanner: false,
        home: Transition(),
        theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(),
        ));
  }
}
