import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'buscar.dart';


class Perfil2 extends StatefulWidget {
  static String tag = '/EGProfileScreen';

  @override
  Perfil2State createState() => Perfil2State();
}

String user = "";
String userName = "";
String about = "";
String token = "";
int posts = 0;
String nPosts = "";
int follow = 0;
String nFollow = "";
int followers = 0;
String nFollowers = "";
bool unfollow= true;
var linkfoto = "";
int _selectedIndex = 0;

class Perfil2State extends State<Perfil2> {
  final _pages = [SearchW()];
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
        leading: Icon(Icons.arrow_back).onTap(() {
          Navigator.pop(context);
        }),
        title: Text(user, style: boldTextStyle(size: 20,color: Colors.white)),
        automaticallyImplyLeading: false,
        backgroundColor: azul_logo,
        actions: <Widget>[
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            16.height,
            Stack(
              children: [
                    Column(
                      children: [
                        Image.asset(insignia, width: 90, height: 90),
                      ],
                      ),
                CircleAvatar(
                  radius: 70,
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
                    nFollow= follow.toString(),
                    style: boldTextStyle(size: 16, color: black),
                    semanticsLabel: "nFollow",
                  ).paddingLeft(92),
                  Text("Seguidores",
                      style: boldTextStyle(size: 12, color: black)).paddingLeft(92)
                ],
              ),
              Column(
                children: [
                  Text(
                    nFollowers= followers.toString(),
                    style: boldTextStyle(size: 16, color: black),
                    semanticsLabel: "nFollowers",
                  ).paddingRight(92),
                  Text("Seguidos", style: boldTextStyle(size: 12, color: black)).paddingRight(92)
                ],
              ),
          ],
              ),
                ElevatedButton.icon(
                  label: Text(unfollow ? 'Seguir Perfil' : 'Dejar de seguir'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 40),
                    //primary: Colors.lightBlueAccent[200],
                    primary: unfollow? Color.fromRGBO(68, 102, 216, 1.0) : Colors.red,
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  icon: Icon(unfollow? Icons.person_add : Icons.person_add_disabled, size: 18),
                  onPressed: () {
                    unfollow = !unfollow;
                    if(unfollow){follow = follow - 1;}
                    else{follow = follow + 1;}
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
           child:Column(
              children: [
                Text(
                  nPosts= posts.toString(),
                  style: boldTextStyle(size: 16, color: black),
                  semanticsLabel: "nPosts",
                ),
                Text("Posts", style: boldTextStyle(size: 12, color: black))
              ],
            ),
           ),
          ],
        ).paddingAll(16),
      ),

      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.grey[200],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black38),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black38),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop, color: Colors.black38),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: azul_logo,
       // body:_pages.elementAt(_selectedIndex),
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () {
          posts = posts + 1;
          toast('post');
          setState(() {});
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
