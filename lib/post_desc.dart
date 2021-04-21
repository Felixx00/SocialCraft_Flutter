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
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        10.height,
        Text(
          "hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola hola como estas",
          style: TextStyle(fontSize: 20),
        ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.auto_awesome_mosaic, color: azul_logo, size: 20),
                  16.width,
                  Text("Categoria:", style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.bar_chart_rounded, color: azul_logo, size: 20),
                  16.width,
                  Text("DIficultad:", style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.av_timer, color: azul_logo, size: 20),
                  16.width,
                  Text("Duracion:", style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.design_services, color: azul_logo, size: 20),
                  16.width,
                  Text("Materiales:", style: secondaryTextStyle())
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
