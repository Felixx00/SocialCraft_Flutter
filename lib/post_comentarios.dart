import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'subir_comentario.dart';

List comentarios = [
  {
    "id" : 1,
    "username": "usuario1",
    "foroPerfil": "aqui també",
    "valoracion": "3",
    "texto": "muy buen tutorial",
    "fotografia": "aqui",
    "datahora": "16/09/21",
    "idUsuario": 3,
  },
  {
    "id" : 2,
    "username": "usuario2",
    "foroPerfil": "aqui també",
    "valoracion": "2",
    "texto": "",
    "fotografia": "",
    "datahora": "16/09/21",
    "idUsuario": 3,
  }
];

var linkfoto = "";
String text = "molt bont tutorial";
String username =  "usuari";
double puntos = 0;

class PostComentarios extends StatelessWidget {
  final String tutId;
  PostComentarios(this.tutId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        //onRefresh: ()=> X,
        child: ListView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 5),
                Column(
                  //children: comentarios.isEmpty,

                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubirComentario(tutId),
              )
          );
        },
        backgroundColor: azul_logo,
        child: Icon(
          Icons.add_comment,
          color: Colors.white,
        ),
      ),

    );

  }
}