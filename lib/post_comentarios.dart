import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
//import 'package:flutter/subir_comentario.dart';

class PostComentarios extends StatelessWidget {
  final String titulo;
  PostComentarios(this.titulo);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      children: <Widget>[
        Text(titulo,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        10.height,
        Divider(
          height: 20,
          thickness: 3,
          indent: 20,
          endIndent: 20,
        ),
        IconButton(
          icon: Icon(Icons.add_comment),
          onPressed: () {
            Navigator.pushNamed(context, "subir_comentario");
          },
        )
      ],
    );
  }
}
