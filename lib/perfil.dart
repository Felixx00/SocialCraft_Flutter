import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Perfil extends StatefulWidget {
  static String tag = '/EGProfileScreen';

  @override
  PerfilState createState() => PerfilState();
}

String user = "";
String about = "";
String token;

class PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
    init();
    username().then((respuesta) {
      //print(respuesta.data['name']);
      user = respuesta.data['name'];
      about = respuesta.data['about'];
      setState(() {});
    });
    setState(() {});

    //init();
  }

  init() async {
    final storage = new FlutterSecureStorage();
    token = await storage.read(key: 'jwt');
    print(token);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

/*
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLnNvY2lhbGNyYWZ0LmNsdWIiLCJpYXQiOjE2MTY2NjY0MjMsInVzZXJJZCI6IjEyIn0.zSfDG1InrzwC9dQWwYbinGyqW27DzpNNnr9bHZw_AvhfKFDPLXeR4Gf6JNw9FhsrmyzyRg0Z5TtngROGglRee8fAIUBAndnNCj10RR6R-TWs71SkZa_3-NKK4Y8LWtNBTJbjgOx_9IGRyL7TmAyliHNBnA7WRImwmF9gLbH0ay-s64VY7y70BW3ez0iasaJrzDTEGJqOcdhWo7eq-3F1fgSOTtW2TGfT-6zOCA7klSPwHdiddrdhmRS5nrXme3tZ-Hb34Lhy7He-Bgg10PFPxS2J7CtVTNR_heUxzXw3TSObtcSqYTiHRmVoJfP4UaDmbWTa7A96-TpjnnZZwj3kYg';
      */

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
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(socialcraft_logo_letras_blanco,
            width: 140, height: 140),
        // child: Image.asset(insignia, width: 90, height: 90),
        automaticallyImplyLeading: false,
        backgroundColor: azul_logo,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.pushNamed(context, "settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Stack(
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: azul_logo,
                      child: Text("?",
                          style: boldTextStyle(size: 20, color: white))),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent[100],
                      radius: 15,
                      child: Icon(Icons.camera_alt_rounded,
                          size: 20, color: azul_logo),
                    ).onTap(() async {
                      //ImagePicker().getImage(source: ImageSource.gallery);
                    }),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "64",
                    style: boldTextStyle(size: 16, color: black),
                  ),
                  Text("Posts", style: boldTextStyle(size: 12, color: black))
                ],
              ),
              Column(
                children: [
                  Text("124", style: boldTextStyle(size: 16, color: black)),
                  Text("Seguidores",
                      style: boldTextStyle(size: 12, color: black))
                ],
              ),
              Column(
                children: [
                  Text("212", style: boldTextStyle(size: 16, color: black)),
                  Text("Seguidos", style: boldTextStyle(size: 12, color: black))
                ],
              ),
            ]),
            12.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(user, style: boldTextStyle(size: 20)).paddingLeft(12),
                    2.height,
                    Text(about, style: secondaryTextStyle(size: 14))
                        .paddingLeft(12),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(insignia, width: 90, height: 90),
                  ],
                ),
              ],
            ),
            10.height,
            ElevatedButton.icon(
              label: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(180, 30),
                //primary: Colors.lightBlueAccent[200],
                primary: Color.fromRGBO(68, 102, 216, 1.0),
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              icon: Icon(Icons.person_outline_sharp, size: 18),
              onPressed: () {
                Navigator.pushNamed(context, "editar");
                setState(() {});
              },
            ).center(),
            Divider(
              height: 30,
              thickness: 3,
              color: Colors.grey[650],
            ),
          ],
        ).paddingAll(16),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: azul_logo,
      ),
    );
  }
}
