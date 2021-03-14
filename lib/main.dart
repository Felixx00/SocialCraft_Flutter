import 'package:flutter/material.dart';
import 'text.dart';
import 'ruedita.dart';
import 'edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      'texto': (BuildContext context) => Texto(),
      'ruedita': (BuildContext context) => CustomLoaderScreen(),
      'edit': (BuildContext context) => Edit(),
    }, home: MyHome());
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
              onPressed: () => Navigator.pushNamed(context, "texto"),
            ),
            OutlinedButton(
              child: Text("Register"),
              onPressed: () => Navigator.pushNamed(context, "ruedita"),
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


/*
return List<Widget>[Center(
      child: OutlinedButton(
        child: Text("Login"),
        onPressed: () => Navigator.pushNamed(context, "texto"),
      ),
    )];
    */