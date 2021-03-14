import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      'login': (BuildContext context) => Login(),
      'register': (BuildContext context) => Register(),
      'edit': (BuildContext context) => Edit(),
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
              child: Text("Edit"),
              onPressed: () => Navigator.pushNamed(context, "edit"),
            ),
          ],
        )
        // ignore: unnecessary_statements

        );
  }
}
