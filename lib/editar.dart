import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';

class Editar extends StatefulWidget {
  static String tag = '/editar';

  @override
  EditarState createState() => EditarState();
}

class EditarState extends State<Editar> {
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
          title: const Text('Editar Perfil'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: OutlinedButton.icon(
                label: Text('Guardar', style: primaryTextStyle(color: white)),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(color: Colors.white, width: 1.5),
                ),
                icon: Icon(Icons.check),
                onPressed: () {
                  print('Pressed');
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              20.height,
              CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.blue,
                  child:
                      Text("?", style: boldTextStyle(size: 20, color: white))),
              7.height,
              Text(
                'Cambiar foto de perfil',
                style: TextStyle(color: azul_logo),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.portrait),
                            border: InputBorder.none,
                            hintText: "Nombre",
                          ),
                        ).paddingOnly(left: 8, top: 10),
                      ).cornerRadiusWithClipRRect(12).paddingOnly(bottom: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText: "Nombre de Usuario",
                          ),
                        ).paddingOnly(left: 8, top: 10),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 8, bottom: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            border: InputBorder.none,
                            hintText: "Email",
                          ),
                        ).paddingOnly(left: 8, top: 10),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 8, bottom: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            icon: Icon(Icons.location_on),
                            border: InputBorder.none,
                            hintText: "Dirección",
                          ),
                        ).paddingOnly(left: 8, top: 10),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 8, bottom: 8),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton.icon(
                            label: Text('Modificar Contraseña'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(180, 40),
                              //primary: Colors.lightBlueAccent[200],
                              primary: Color.fromRGBO(68, 102, 216, 1.0),
                              onPrimary: Colors.white,
                              onSurface: Colors.grey,
                            ),
                            icon: Icon(Icons.lock_outline_rounded, size: 18),
                            onPressed: () {},
                          )).paddingTop(10),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
