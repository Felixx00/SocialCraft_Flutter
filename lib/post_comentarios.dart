import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'subir_comentario.dart';

List comentarios = [
  {
    "id" : 1,
    "username": "usuario1",
    "fotoPerfil": "https://cursosvirtualesgratis.com/wp-content/uploads/2018/02/time-totorial.jpg",
    "valoracion": "3",
    "texto": "muy buen tutorial",
    "fotografia": "https://cursosvirtualesgratis.com/wp-content/uploads/2018/02/time-totorial.jpg",
    "datahora": "16/08/23",
    "idUsuario": 3,
  },
  {
    "id" : 2,
    "username": "usuario2",
    "fotoPerfil": 'https://cursosvirtualesgratis.com/wp-content/uploads/2018/02/time-totorial.jpg',
    "valoracion": "2",
    "texto": "En la programación de computadoras, un comentario es una construcción del lenguaje de programación destinada a incrustar",
    "fotografia": 'https://como-funciona.com/wp-content/uploads/2019/01/c%C3%B3mo-funciona-un-tutorial.jpg',
    "datahora": "16/02/21",
    "idUsuario": 3,
  },
  {
    "id" : 4,
    "username": "usuario2",
    "fotoPerfil": 'https://cursosvirtualesgratis.com/wp-content/uploads/2018/02/time-totorial.jpg',
    "valoracion": "2",
    "texto": "",
    "fotografia": "",
    "datahora": "16/05/21",
    "idUsuario": 5,
  },
  {
    "id" : 5,
    "username": "usuario2",
    "fotoPerfil": 'https://cursosvirtualesgratis.com/wp-content/uploads/2018/02/time-totorial.jpg',
    "valoracion": "2",
    "texto": "",
    "fotografia": 'https://como-funciona.com/wp-content/uploads/2019/01/c%C3%B3mo-funciona-un-tutorial.jpg',
    "datahora": "16/05/21",
    "idUsuario": 5,
  },
];


class PostComentarios extends StatelessWidget {
  final String tutId;
  PostComentarios(this.tutId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: comentarios.length,
            itemBuilder: (context,i) => new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                    comentarios[i]["fotoPerfil"])),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget> [
                              Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: comentarios[i]["username"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17.0,
                                                  color: Colors.black),
                                              ),
                                              TextSpan(
                                                text: " · ${comentarios[i]["datahora"]}",
                                                style: TextStyle(
                                                  fontSize: 16.0, color: Colors.grey))
                                            ]),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                          flex: 5,
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(right: 3.0),
                                              child: Icon(
                                                Icons.expand_more,
                                                color: Colors.grey,
                                              ),
                                          ),
                                    ],
                                  ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      comentarios[i]["texto"],
                                      style: TextStyle(fontSize: 15.0),
                                    )
                                ),
                              ),
                              Container(
                                height: comentarios[i]["fotografia"] != "" ? 300.0: 0.0,
                                width: 300.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          comentarios[i]["fotografia"])),
                                ),
                              ).paddingOnly(top: 5, bottom: 5),
                            ],
                          ),
                      )
                    ],
                  ),
                )
              ],
            ),
        ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubirComentario(tutId),
            ),
          );
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