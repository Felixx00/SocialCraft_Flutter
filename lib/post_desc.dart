import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';

class PostDesc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      children: <Widget>[
        Text("holaa",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        10.height,
        Text(
          "hola hola hola hola como estas?",
          style: TextStyle(fontSize: 16),
        ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.brightness_5, color: azul_logo, size: 18),
                  16.width,
                  Text("Categoria", style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.brightness_5, color: azul_logo, size: 18),
                  16.width,
                  Text("DIficultad", style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.brightness_5, color: azul_logo, size: 18),
                  16.width,
                  Text("Duracion", style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.brightness_5, color: azul_logo, size: 18),
                  16.width,
                  Text("Materiales", style: secondaryTextStyle())
                ]),
              ],
            ),
            15.height,
            /*
            Column(
              children: List.generate(
                1,
                (int index) {
                  return ListTile(
                    leading: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: Text("hola"),
                  );
                },
              ),
            ),
            */
          ],
        ),
      ],
    );
  }
}
