import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:socialcraft/utils/images.dart';

List categories = [
  {
    "id" : 1,
    "name": "Covid-19"
  },
  {
    "id" : 2,
    "name": "Ceramica"
  },
  {
    "id" : 3,
    "name": "Jardineria"
  },
  {
    "id" : 4,
    "name": "Paseo de Canela"
  },
  {
    "id" : 5,
    "name": "Carpinteria"
  },
  {
    "id" : 6,
    "name": "Vidreo"
  },
  {
    "id" : 7,
    "name": "LifeHacks"
  },
  {
    "id" : 8,
    "name": "Plastelina"
  },
];

void main() => runApp(Search());
FocusNode nameNode;

class Search extends StatefulWidget {
  @override
  SearchW createState() => SearchW();
}
class SearchW extends State<Search> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String busqueda = "";
  @override
  Widget build(BuildContext context) {
    Widget getCategories(){
      List categoriaItems = [
        "Covid-19",
        "Origami",
        "Cermaica",
        "Reposteria",
        "Sacar a Canela a paseo",
      ];
      }
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      cursorColor: azul_logo,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: azul_logo),
                        border: InputBorder.none,
                        hintText: "Busca",
                      ),
                      onChanged: (texto) {
                        busqueda = texto;
                      },
                    ).paddingLeft(10),
                  ).cornerRadiusWithClipRRect(12).paddingOnly(top: 70, left:20, right: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: List.generate(categories.length,(index){
                      return Padding(
                        padding: const EdgeInsets.only(right:1,
                        bottom:1),
                        child: Column(
                          children:  <Widget>[
                            Container(
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3.0
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Text(categories[index]["name"],style: TextStyle(
                                  color: black,
                                ))
                            ),
                          ],
                        ),
                      );
                    })),
                  )
                ],
            ),
          )
        ),

      debugShowCheckedModeBanner: false,
    );
  }
}