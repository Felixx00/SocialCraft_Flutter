import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Logros extends StatefulWidget {
  static String tag = '/settings';

  @override
  LogrosState createState() => LogrosState();
}

class LogrosState extends State<Logros> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Configuración'),
          backgroundColor: azul_logo,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              30.height,
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: Text('Cerrar Sesión'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 40),
                      primary: Colors.red[400],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    icon: Icon(Icons.exit_to_app_rounded, size: 18),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  )).paddingTop(10),
              20.height,
              Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: Colors.black38,
              ),
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: Text('Eliminar Cuenta'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 40),
                      primary: Colors.red[400],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    icon: Icon(Icons.close, size: 18),
                    onPressed: () {
                      showAlertDialogEliminar(context);
                    },
                  )).paddingTop(10),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Sí"),
    onPressed: () async {
      final storage = new FlutterSecureStorage();
      await storage.deleteAll();
      String token = await storage.read(key: 'jwt');
      print(token);
      Navigator.pushNamedAndRemoveUntil(
          context, 'login', (Route<dynamic> route) => false);
    },
  );
  Widget continueButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    content: Text("¿Estas seguro que deseas cerrar sesión?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogEliminar(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Sí"),
    onPressed: () async {
      final storage = new FlutterSecureStorage();
      String token = await storage.read(key: 'jwt');

      print(token);
      final response = await http.post(
        Uri.https('api.socialcraft.club', 'users/deleteAccount'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        await storage.deleteAll();
        print(response.body);
        Navigator.pushNamedAndRemoveUntil(
            context, 'login', (Route<dynamic> route) => false);
      } else {
        Navigator.pop(context);
        throw Exception('Failed to load response');
      }
    },
  );
  Widget continueButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    content: Text("¿Estas seguro que deseas eliminar tu cuenta?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
