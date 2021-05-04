import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';

class PostPasos extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final List<dynamic> pasos;
  PostPasos(this.titulo, this.descripcion, this.pasos);
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
              final pasoText = pasos[index]['Texto'];
              return Column(
                children: [
                  ListTile(
                    leading: Text("${index + 1}",
                        style: TextStyle(
                            fontSize: 25,
                            color: azul_logo,
                            fontWeight: FontWeight.bold)),
                    title: Image.network('https://picsum.photos/250?image=9'),
                    subtitle: Text(pasoText,
                        style: TextStyle(fontSize: 16, color: Colors.black)),
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
