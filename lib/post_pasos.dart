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
  var linkfoto = "";

  PostPasos(this.titulo, this.descripcion, this.pasos, this.tutId);

  Future getImage() async {
    var r = FirebaseStorage.instance.ref('Posts/' + tutId + '/paso1');
    try {
      await r.getDownloadURL();
      var ref =
          FirebaseStorage.instance.ref().child('Posts/' + tutId + '/paso1');
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
