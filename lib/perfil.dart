import 'dart:convert';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Perfil extends StatefulWidget {
  static String tag = '/EGProfileScreen';

  @override
  PerfilState createState() => PerfilState();
}

String user = "";
String userName = "";
String about = "";
String token = "";
var linkfoto = "";

class PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
    init();

    setState(() {});

    //init();
  }

  init() async {
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    //print(token);
    username().then((respuesta) async {
      //print(respuesta.data['name']);
      user = respuesta.data['name'];
      if (respuesta.data['about'] == null) {
        about = "SocialCraft!";
      } else {
        about = respuesta.data['about'];
      }
      userName = respuesta.data['username'];

      await Firebase.initializeApp();
      await getImage();
      setState(() {});
    });
    //await FirebaseAuth.instance.signInAnonymously();

    setState(() {});
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
                    /*child: Image.network(
                      link_foto.toString(),
                      fit: BoxFit.scaleDown,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Text(link_foto.toString());
                      },
                    ),*/

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
                  /*Image.network(
                    linkfoto,
                    width: 100,
                    height: 100,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Text('Your error widget...');
                    },
                  ).cornerRadiusWithClipRRect(60),*/
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
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                      leading: new Icon(
                                          Icons.add_a_photo_rounded,
                                          color: azul_logo),
                                      title: new Text('Editar foto de perfil'),
                                      onTap: () async {
                                        var foto = await ImagePicker().getImage(
                                            source: ImageSource.gallery);
                                        Navigator.pop(context);
                                        print(foto);

                                        if (foto != null) {
                                          final _firebaseStorage =
                                              FirebaseStorage.instance;
                                          var file = File(foto.path);
                                          var snapshot = await _firebaseStorage
                                              .ref()
                                              .child(userName + '/image')
                                              .putFile(file);

                                          //print(foto.path);
                                        } else {
                                          print('No image selected.');
                                        }

                                        init();
                                        setState(() {});
                                      }),
                                  new ListTile(
                                    leading: new Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                    title: new Text('Eliminar foto de perfil'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      final _firebaseStorage =
                                          FirebaseStorage.instance;
                                      var snapshot = await _firebaseStorage
                                          .ref()
                                          .child(userName + '/image')
                                          .delete();
                                      init();
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
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
        //backgroundColor: Colors.grey[200],
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
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () {
          toast('post');
        },
        backgroundColor: azul_logo,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
