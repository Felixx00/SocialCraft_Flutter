import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/perfil.dart';
import 'package:socialcraft/perfil2.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostDesc extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final String usuario;
  final String rate;
  final String dificultad;
  final String categoria;
  final String materiales;
  final String duracion;
  final String idUsuario;
  bool correct = false;
  var myself;

  PostDesc(
      this.titulo,
      this.descripcion,
      this.usuario,
      this.rate,
      this.dificultad,
      this.categoria,
      this.materiales,
      this.duracion,
      this.idUsuario);
  @override
  Widget build(BuildContext context) {
    if (rate != "0") correct = true;
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      children: <Widget>[
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
                  Icon(Icons.account_circle, color: azul_logo, size: 30),
                  16.width,
                  InkWell(
                    child: Text("@" + usuario,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16, color: azul_logo))
                        .paddingOnly(left: 16, right: 16, top: 5),
                    onTap: () {
                      Myself().then((response) async {
                        myself = response.data['username'];
                        print(myself);
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => myself == usuario
                              ? Perfil()
                              : Perfil2(
                                  idUsuario,
                                ),
                        ),
                      ); //.then((value) => setState(() {}));
                    },
                  ),
                  //Text(
                  //"Usuario: " + usuario,
                  //style: TextStyle(fontSize: 16),
                  //)
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.star_outlined, color: azul_logo, size: 30),
                  16.width,
                  Text(
                    correct ? AppLocalizations.of(context).valoracionDosPuntos + rate + "/5" : AppLocalizations.of(context).valoracionDosPuntos + " -",
                    style: TextStyle(fontSize: 16),
                  )
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.bar_chart_rounded, color: azul_logo, size: 30),
                  16.width,
                  Text(
                    AppLocalizations.of(context).dificultad + ": " + dificultad,
                    style: TextStyle(fontSize: 16),
                  )
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.grid_view, color: azul_logo, size: 30),
                  16.width,
                  Text(
                    AppLocalizations.of(context).categoria+": " + categoria,
                    style: TextStyle(fontSize: 16),
                  )
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.av_timer, color: azul_logo, size: 30),
                  16.width,
                  Text(
                    AppLocalizations.of(context).duracion + ": " + duracion + "min",
                    style: TextStyle(fontSize: 16),
                  )
                ]),
                16.height,
                Row(children: [
                  Icon(Icons.brush_rounded, color: azul_logo, size: 30),
                  16.width,
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      AppLocalizations.of(context).materiales + ": " + materiales,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Future<Resp> Myself() async {
  final storage2 = new FlutterSecureStorage();
  String token = await storage2.read(key: 'jwt');
  final response = await http.get(
    Uri.https('api.socialcraft.club', 'users/getMyProfile'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    return Resp.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load response');
  }
}
