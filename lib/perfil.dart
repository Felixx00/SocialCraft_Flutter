import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'buscar.dart';
import 'home.dart';
import 'post.dart';

class Perfil extends StatefulWidget {
  static String tag = '/EGProfileScreen';

  @override
  PerfilState createState() => PerfilState();
}

String user = "";
String userName = "";
String about = "";
String token = "";
String nPosts = "";
int follow = 0;
String nFollow = "";
int followers = 0;
String nFollowers = "";
bool unfollow = true;
var linkfoto = "";
List<dynamic> posts = [];

class PerfilState extends State<Perfil> {
  @override
  initState() {
    super.initState();
    init();
    setState(() {});
  }

  bool loading = true;

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
    getMyTutorials().then((respuesta) async {
      posts = respuesta.list;
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

  Future<Resp> getMyTutorials() async {
    var map = new Map<String, dynamic>();
    map['limit'] = "100";
    map['offset'] = "0";
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/getMyTutorials'),
      body: map,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<Resp> editRuta() async {
    var map = new Map<String, dynamic>();
    var ref = FirebaseStorage.instance.ref().child(userName + '/image');
    map['rutaFoto'] = (await ref.getDownloadURL()).toString();
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/users/editProfile'),
      body: map,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future getImage() async {
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
    print(linkfoto);
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = context.width() / 2;
    double cardHeight = context.height() / 4;
    return Scaffold(
      appBar: AppBar(
        title: Text(userName,
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ))),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            16.height,
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'logros');
                    },
                    child: Image.asset(
                      trophy,
                      width: 40,
                      height: 40,
                    ),
                  )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
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
                                          title:
                                              new Text('Editar foto de perfil'),
                                          onTap: () async {
                                            var foto = await ImagePicker()
                                                .getImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Navigator.pop(context);
                                            print(foto);

                                            if (foto != null) {
                                              final _firebaseStorage =
                                                  FirebaseStorage.instance;
                                              var file = File(foto.path);
                                              await _firebaseStorage
                                                  .ref()
                                                  .child(userName + '/image')
                                                  .putFile(file);
                                              editRuta();
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
                                        title:
                                            new Text('Eliminar foto de perfil'),
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
                ),
              ],
            ),
            15.height,
            Column(
              children: [
                Text(user, style: boldTextStyle(size: 20)).paddingLeft(12),
                2.height,
                Text(about, style: secondaryTextStyle(size: 14))
                    .paddingLeft(12),
              ],
            ),
            15.height,
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Text(
                        nFollow = follow.toString(),
                        style: boldTextStyle(size: 16, color: black),
                        semanticsLabel: "nFollow",
                      ).paddingLeft(92),
                      Text("Seguidores",
                              style: boldTextStyle(size: 12, color: black))
                          .paddingLeft(92)
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        nFollowers = followers.toString(),
                        style: boldTextStyle(size: 16, color: black),
                        semanticsLabel: "nFollowers",
                      ).paddingRight(92),
                      Text("Seguidos",
                              style: boldTextStyle(size: 12, color: black))
                          .paddingRight(92)
                    ],
                  ),
                ],
              ),
              ElevatedButton.icon(
                label: Text('Editar Perfil'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 40),
                  primary: Color.fromRGBO(68, 102, 216, 1.0),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                icon: Icon(Icons.person_outline_sharp, size: 18),
                onPressed: () {
                  Navigator.pushNamed(context, "editar");
                  setState(() {});
                },
              ),
            ]),
            10.height,
            Divider(
              height: 30,
              thickness: 3,
              color: Colors.grey[650],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    nPosts = posts.length.toString(),
                    style: boldTextStyle(size: 16, color: black),
                    semanticsLabel: "nPosts",
                  ),
                  Text("Posts", style: boldTextStyle(size: 12, color: black))
                ],
              ),
            ),
            Column(
              children: List.generate(
                //nPosts.toInt(),
                1,
                (int index) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: posts.length,
                    padding: EdgeInsets.all(16),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: cardWidth / cardHeight),
                    itemBuilder: (context, index) => Product(index),
                  );
                },
              ),
            )
          ],
        ).paddingAll(16),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () {
          Navigator.pushNamed(context, 'upload');
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

class Product extends StatelessWidget {
  final int pos;

  Product(this.pos);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Post(posts[pos]['id']).launch(context);
        Perfil().launch(context);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
              tag: Image.network(posts[pos]['fotoRuta']),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(12.0),
                child: Image.network(
                  posts[pos]['fotoRuta'],
                  height: context.height() / 6,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(posts[pos]['titulo'],
                      style: primaryTextStyle(color: Colors.black)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
