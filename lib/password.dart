import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  init() async {
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String passActual = '';
  String passNew = '';
  String passNewConfirm = '';
  String token = "";
/*
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLnNvY2lhbGNyYWZ0LmNsdWIiLCJpYXQiOjE2MTY2NjY0MjMsInVzZXJJZCI6IjEyIn0.zSfDG1InrzwC9dQWwYbinGyqW27DzpNNnr9bHZw_AvhfKFDPLXeR4Gf6JNw9FhsrmyzyRg0Z5TtngROGglRee8fAIUBAndnNCj10RR6R-TWs71SkZa_3-NKK4Y8LWtNBTJbjgOx_9IGRyL7TmAyliHNBnA7WRImwmF9gLbH0ay-s64VY7y70BW3ez0iasaJrzDTEGJqOcdhWo7eq-3F1fgSOTtW2TGfT-6zOCA7klSPwHdiddrdhmRS5nrXme3tZ-Hb34Lhy7He-Bgg10PFPxS2J7CtVTNR_heUxzXw3TSObtcSqYTiHRmVoJfP4UaDmbWTa7A96-TpjnnZZwj3kYg'; */

  Future<Resp> cambiarpassword(String p, String p2) async {
    var map = new Map<String, dynamic>();
    map['password'] = p;
    map['cpassword'] = p2;
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'users/editProfile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map,
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
          title: Text(AppLocalizations.of(context).cambiarContrasena),
          backgroundColor: azul_logo,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              30.height,
              Image.asset(key, width: 120, height: 120),
              15.height,
              Text(
                AppLocalizations.of(context).cambiarContrasena,
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
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (newValue) {
                            passActual = newValue;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock_rounded, color: azul_logo),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).contrasenaActual
                          ),
                        ).paddingOnly(left: 8),
                      ).cornerRadiusWithClipRRect(12).paddingOnly(bottom: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (newValue) {
                            passNew = newValue;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock_rounded, color: azul_logo),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).nuevaContrasena,
                          ),
                        ).paddingOnly(left: 8),
                      )
                          .cornerRadiusWithClipRRect(12)
                          .paddingOnly(top: 10, bottom: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[100]),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (newValue) {
                            passNewConfirm = newValue;
                          },
                          decoration: InputDecoration(
                            icon:
                                Icon(Icons.lock_open_rounded, color: azul_logo),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).confirmaNuevaContrasena,
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
                    label: Text(AppLocalizations.of(context).guardar),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 40),
                      //primary: Colors.lightBlueAccent[200],
                      primary: azul_logo,
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    icon: Icon(Icons.check_circle_outline_rounded, size: 18),
                    onPressed: () {
                      if (passNew == passNewConfirm && passNew != '') {
                        cambiarpassword(passNew, passActual);
                        Navigator.pop(context);
                      } else {
                        print('no coinciden');
                      }
                    },
                  )).paddingTop(10),
            ],
          ),
        ),
      ),
    );
  }
}
