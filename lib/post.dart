import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/post_comentarios.dart';
import 'editpost.dart';
import 'post_pasos.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;

import 'post_desc.dart';

class Post extends StatefulWidget {
  final String idPost;
  Post(this.idPost);
  @override
  PostState createState() => PostState();
}

String token = "";
String tutId = "";
String titulo = "";
String descripcion = "";
String rutaFoto = "";
String video = "";
String dificultad = "";
String materiales = "";
String duracion = "";
String usuario = "";
String rate = "";
String categoria = "";
String idUsuario = "";
List<dynamic> pasos = [];
List<dynamic> comments = [];

class PostState extends State<Post> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    tutId = widget.idPost;
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    post().then((respuesta) async {
      titulo = respuesta.data['titulo'];
      descripcion = respuesta.data['descripcion'];
      video = respuesta.data['video'];
      dificultad = respuesta.data['dificultad'];
      materiales = respuesta.data['materiales'];
      duracion = respuesta.data['duracion'];
      usuario = respuesta.data['usuario'];
      rate = respuesta.data['rate'];
      categoria = respuesta.data['catName'];
      pasos = respuesta.data['pasos'];
      comments = respuesta.data['comments'];
      rutaFoto = respuesta.data['rutaFoto'];
      idUsuario = respuesta.data['idUsuario'];
      if (dificultad == "1") dificultad = "Fácil";
      if (dificultad == "2") dificultad = "Intermedio";
      if (dificultad == "3") dificultad = "Difícil";
      setState(() {});
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<Resp> post() async {
    var map = new Map<String, dynamic>();
    map['tutid'] = tutId;
    final response = await http.get(
      Uri.https('api.socialcraft.club', '/tutorials/getTutorial', map),
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

  Future<Resp> deletePost() async {
    var map = new Map<String, dynamic>();
    map['tutId'] = tutId;
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/deleteTutorial'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: Icon(Icons.arrow_back).onTap(() {
                  Navigator.pop(context);
                }),
                title: Text(titulo, style: GoogleFonts.comfortaa(fontSize: 25)),
                expandedHeight: 320,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(rutaFoto)),
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
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text("Pasos",
                            style: GoogleFonts.comfortaa(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text("Comentarios",
                            style: GoogleFonts.comfortaa(
                                fontSize: 15, fontWeight: FontWeight.bold))),
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPost(tutId, pasos),
                        ),
                      );
                      init();
                    },
                  )
                ],
              )
            ];
          },
          body: TabBarView(children: <Widget>[
            PostDesc(titulo, descripcion, usuario, rate, dificultad, categoria,
                materiales, duracion, idUsuario),
            PostPasos(titulo, descripcion, pasos, tutId),
            PostComentarios(tutId)
          ]),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
        child: Text("Sí"),
        onPressed: () async {
          deletePost().then((respuesta) async {
            toast("Tutorial eliminado correctamente", bgColor: toast_color);
            //Navigator.pushNamed(context, "barra");
            Navigator.pop(context);
            Navigator.pop(context);
            setState(() {});
          });
        });
    Widget continueButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("¿Estas seguro que deseas eliminar el tutorial?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
