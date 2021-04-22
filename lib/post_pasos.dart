import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';

class PostPasos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      children: <Widget>[
        Text("holaa",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        10.height,
        Text(
          "hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola como estas",
          style: TextStyle(fontSize: 20),
        ),
        20.height,
        Text(
          "Pasos",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Column(
          children: List.generate(
            2,
            (int index) {
              final pasoText = "holaaa";
              return ListTile(
                leading: Text("${index + 1}",
                    style: TextStyle(
                        fontSize: 25,
                        color: azul_logo,
                        fontWeight: FontWeight.bold)),
                title: Text(pasoText),
              );
            },
          ),
        )
      ],
    );
  }
}
