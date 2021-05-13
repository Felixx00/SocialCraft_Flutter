import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';

class PostPasos extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final List<dynamic> pasos;
  final String tutId;

  PostPasos(this.titulo, this.descripcion, this.pasos, this.tutId);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      children: <Widget>[
        Text(
          "Pasos",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Column(
          children: List.generate(
            pasos.length,
            (int index) {
              if (pasos[index]['Foto'] == null) pasos[index]['Foto'] = "";
              final pasoText = pasos[index]['Texto'];
              return Column(
                children: [
                  ListTile(
                    leading: Text("${index + 1}",
                        style: TextStyle(
                            fontSize: 25,
                            color: azul_logo,
                            fontWeight: FontWeight.bold)),
                    title: Text(pasoText,
                            style: TextStyle(fontSize: 16, color: Colors.black))
                        .paddingOnly(bottom: 15, top: 15),
                    subtitle: Container(
                      height: pasos[index]['Foto'] != "" ? 300.0 : 0.0,
                      width: 300.0,
                      child: Image.network(pasos[index]['Foto'])
                          .paddingOnly(bottom: 10),
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 3,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
