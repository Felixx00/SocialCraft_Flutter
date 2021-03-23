import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/images.dart';

class Password extends StatefulWidget {
  static String tag = '/password';

  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<Password> {
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
          title: const Text('Cambiar Contraseña'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              30.height,
              Image.asset(key, width: 120, height: 120),
              15.height,
              Text(
                'Cambiar Contraseña',
                style: TextStyle(fontSize: 28),
              ),
              20.height,
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock_rounded),
                            border: InputBorder.none,
                            hintText: "Contraseña actual",
                          ),
                        ).paddingOnly(left: 8),
                      ).cornerRadiusWithClipRRect(12).paddingOnly(bottom: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock_rounded),
                            border: InputBorder.none,
                            hintText: "Nueva Contraseña",
                          ),
                        ).paddingOnly(left: 8),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 10, bottom: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock_open_rounded),
                            border: InputBorder.none,
                            hintText: "Confirma nueva contraseña",
                          ),
                        ).paddingOnly(left: 8),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 10, bottom: 10),
                    ],
                  )),
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 40),
                      //primary: Colors.lightBlueAccent[200],
                      primary: azul_logo,
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    icon: Icon(Icons.check_circle_outline_rounded, size: 18),
                    onPressed: () {},
                  )).paddingTop(10),
            ],
          ),
        ),
      ),
    );
  }
}
