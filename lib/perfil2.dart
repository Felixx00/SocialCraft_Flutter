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
  final String idUsuario;

  Perfil2(this.idUsuario);

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

class Perfil2State extends State<Perfil2> {
  @override
  void initState() {
    super.initState();
    init();
    setState(() {});
  }

  init() async {
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    usernameId().then((respuesta) async {
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
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<Resp> usernameId() async {
    var map = new Map<String, dynamic>();
    map['userId'] = widget.idUsuario;
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'users/getProfile'),
      body: map,
      headers: {
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
  Future<Resp> followUser(String id) async {
    var map = new Map<String, dynamic>();
    map['userId'] = id;
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/users/followUser'),
      body: map,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }
  Future<Resp> unfollowUser(String id) async {
    var map = new Map<String, dynamic>();
    map['userId'] = id;
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/users/unfollowUser'),
      body:map,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
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
    print(widget.idUsuario);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back).onTap(() {
          Navigator.pop(context);
        }),
        title: Text(userName, style: boldTextStyle(size: 20,color: Colors.white)),
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
              children:[
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: Image.asset(trophy, width: 40, height: 40),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child:Stack(
                    children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    linkfoto,
                  ),
                  onBackgroundImageError: (_, __) {
                    setState(() {
                    });
                  },
                  backgroundColor: azul_logo,
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
                    minimumSize: Size(170, 40),
                    //primary: Colors.lightBlueAccent[200],
                    primary: unfollow? Color.fromRGBO(68, 102, 216, 1.0) : Colors.redAccent[200],
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  icon: Icon(unfollow? Icons.person_add : Icons.person_add_disabled, size: 18),
                  onPressed: () {
                    unfollow = !unfollow;
                    if(unfollow){
                      unfollowUser(widget.idUsuario).then((response) async {
                        follow = follow - 1;
                        setState(() {});
                      });
                    }
                    else{
                      followUser(widget.idUsuario).then((response) async {
                        follow = follow + 1;
                        setState(() {});
                      });
                    }
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
    );
  }
}
