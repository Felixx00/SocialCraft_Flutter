import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Editar extends StatefulWidget {
  static String tag = '/editar';

  @override
  EditarState createState() => EditarState();
}

String token;
String userName = "";
var linkfoto = "";

class EditarState extends State<Editar> {
  @override
  void initState() {
    super.initState();
    init();
  }

/*
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLnNvY2lhbGNyYWZ0LmNsdWIiLCJpYXQiOjE2MTY2NjY0MjMsInVzZXJJZCI6IjEyIn0.zSfDG1InrzwC9dQWwYbinGyqW27DzpNNnr9bHZw_AvhfKFDPLXeR4Gf6JNw9FhsrmyzyRg0Z5TtngROGglRee8fAIUBAndnNCj10RR6R-TWs71SkZa_3-NKK4Y8LWtNBTJbjgOx_9IGRyL7TmAyliHNBnA7WRImwmF9gLbH0ay-s64VY7y70BW3ez0iasaJrzDTEGJqOcdhWo7eq-3F1fgSOTtW2TGfT-6zOCA7klSPwHdiddrdhmRS5nrXme3tZ-Hb34Lhy7He-Bgg10PFPxS2J7CtVTNR_heUxzXw3TSObtcSqYTiHRmVoJfP4UaDmbWTa7A96-TpjnnZZwj3kYg';
      */

  init() async {
    final storage = new FlutterSecureStorage();
    token = await storage.read(key: 'jwt');

    username().then((respuesta) async {
      //print(respuesta.data['name']);

      userName = respuesta.data['username'];

      await Firebase.initializeApp();
      await getImage();
      setState(() {});
    });
    //await FirebaseAuth.instance.signInAnonymously();

    setState(() {});
  }

  Future getImage() async {
    //FirebaseStorage storage = FirebaseStorage.instance;
    /*var ref = FirebaseStorage.instance
        .ref()
        .child('Usuario_Default/default-user-image.png');*/

    var r = FirebaseStorage.instance.ref(userName + '/image');
    try {
      await r.getDownloadURL();
      var ref = FirebaseStorage.instance.ref().child(userName + '/image');
      linkfoto = (await ref.getDownloadURL()).toString();
    } catch (err) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('Usuario_Default/default-user-image.png');
      linkfoto = (await ref.getDownloadURL()).toString();
    }

    //link_foto = ref;
    //linkfoto = (await ref.getDownloadURL()).toString();
    print(linkfoto);
    //var url = await ref.getDownloadURL();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String nombre = '';
  String desc = '';
  String email = '';
  String ciutat = '';

  Future<Resp> cambios() async {
    var map = new Map<String, dynamic>();
    if (nombre != '') {
      map['nombre'] = nombre;
    }
    if (desc != '') {
      map['descripcion'] = desc;
    }
    if (ciutat != '') {
      map['ciudad'] = ciutat;
    }
    if (email != '') {
      map['email'] = email;
    }
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'users/editProfile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.modificar(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<Resp> username() async {
    final response = await http.get(
      Uri.https('api.socialcraft.club', 'users/getMyProfile'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Editar Perfil'),
          backgroundColor: azul_logo,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: OutlinedButton.icon(
                label: Text('Guardar',
                    style: primaryTextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(color: Colors.white, width: 1.5),
                ),
                icon: Icon(Icons.check),
                onPressed: () {
                  cambios().then((respuesta) {
                    if (respuesta.success == false) {
                      print("Algun Parametro Incorrecto");
                    } else {
                      print('a');
                      //finish(context);
                      //setState(() {});
                      finish(context);
                      Navigator.pushNamed(context, 'perfil');
                    }
                  });
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
                backgroundImage: NetworkImage(
                  linkfoto,
                ),
                onBackgroundImageError: (_, __) {
                  setState(() {
                    //this._isError = true;
                  });
                },
                backgroundColor: azul_logo,
              ),
              7.height,
              TextButton(
                child: Text('Cambiar foto de perfil',
                    style: TextStyle(color: azul_logo)),
                onPressed: () async {
                  var foto =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  //Navigator.pop(context);
                  print(foto);

                  //Navigator.pushNamed(context, 'perfil');
                  if (foto != null) {
                    finish(context);
                    Navigator.pushNamed(context, 'perfil');
                    final _firebaseStorage = FirebaseStorage.instance;
                    var file = File(foto.path);
                    var snapshot = await _firebaseStorage
                        .ref()
                        .child(userName + '/image')
                        .putFile(file);

                    //print(foto.path);
                  } else {
                    print('No image selected.');
                  }
                  //finish(context);
                  //Navigator.pushNamed(context, 'perfil');
                  //init();
                  //setState(() {});
                },
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          cursorColor: azul_logo,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (newValue) {
                            nombre = newValue;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.portrait, color: azul_logo),
                            border: InputBorder.none,
                            hintText: "Nombre",
                          ),
                        ).paddingOnly(left: 8),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 10, bottom: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          cursorColor: azul_logo,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (newValue) {
                            desc = newValue;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.person, color: azul_logo),
                            border: InputBorder.none,
                            hintText: "Descripción",
                          ),
                        ).paddingOnly(left: 8),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 10, bottom: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          cursorColor: azul_logo,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (newValue) {
                            email = newValue;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.email, color: azul_logo),
                            border: InputBorder.none,
                            hintText: "Email",
                          ),
                        ).paddingOnly(left: 8),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 10, bottom: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          cursorColor: azul_logo,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (newValue) {
                            ciutat = newValue;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.location_on, color: azul_logo),
                            border: InputBorder.none,
                            hintText: "Ciudad",
                          ),
                        ).paddingOnly(left: 8),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 10, bottom: 10),
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
                            icon: Icon(
                              Icons.lock_outline_rounded,
                              size: 18,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "password");
                            },
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
