import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'post_pasos.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;

import 'post_desc.dart';

class Post extends StatefulWidget {
  @override
  PostState createState() => PostState();
}

String token = "";
String tutId = "1";
String titulo = "";

class PostState extends State<Post> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    post(tutId).then((respuesta) async {
      setState(() {});
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<Resp> post(String tutId) async {
    var map = new Map<String, dynamic>();
    map['tutId'] = tutId;
    final response = await http.get(
      Uri.https('api.socialcraft.club', '/tutorials/getTutorial'),
      //body: map,
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
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: Icon(Icons.arrow_back).onTap(() {
                  finish(context);
                }),
                title: Text("Titulo Post",
                    style: GoogleFonts.comfortaa(fontSize: 25)),
                expandedHeight: 320,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://picsum.photos/250?image=9')),
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(.5),
                    )),
                pinned: true,
                bottom: TabBar(
                  indicatorWeight: 4,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                        child: Text("Descripción",
                            style: GoogleFonts.comfortaa(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text("Pasos",
                            style: GoogleFonts.comfortaa(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, 'editPost');
                    },
                  )
                ],
              )
            ];
          },
          body: TabBarView(children: <Widget>[PostDesc(), PostPasos()]),
        ),
      ),
    );
  }
}
