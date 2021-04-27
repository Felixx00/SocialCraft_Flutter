import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/fonts.dart';

class PostDesc extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String rate;
  final String dificultad;
  final String categoria;
  final String materiales;
  final String duracion;
  PostDesc(this.titulo, this.descripcion, this.rate, this.dificultad,
      this.categoria, this.materiales, this.duracion);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      children: <Widget>[
        Text(titulo,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        20.height,
        Text(
          descripcion,
          style: TextStyle(fontSize: 20),
        ),
        10.height,
        Divider(
          height: 20,
          thickness: 3,
          indent: 20,
          endIndent: 20,
        ),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.star_outlined, color: azul_logo, size: 25),
                  16.width,
                  Text("Valoración: " + rate + "/5",
                      style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.bar_chart_rounded, color: azul_logo, size: 25),
                  16.width,
                  Text("Dificultad: " + dificultad, style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.grid_view, color: azul_logo, size: 25),
                  16.width,
                  Text("Categoria: " + categoria, style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.av_timer, color: azul_logo, size: 25),
                  16.width,
                  Text("Duración: " + duracion + "min",
                      style: secondaryTextStyle())
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.brush_rounded, color: azul_logo, size: 25),
                  16.width,
                  Text("Materiales: " + materiales,
                      style: TextStyle(fontSize: 14)),
                  //style: secondaryTextStyle()),
                ]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
