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
    "name": "Patchwork"
  },
  {
    "id" : 3,
    "name": "Scrapbooking"
  },
  {
    "id" : 4,
    "name": "Pintura"
  },
  {
    "id" : 5,
    "name": "Escultura"
  },
  {
    "id" : 6,
    "name": "Bisutería"
  },
  {
    "id" : 7,
    "name": "Mercería"
  },
  {
    "id" : 8,
    "name": "Papelería"
  },
  {
    "id" : 8,
    "name": "Papelería"
  },
  {
    "id" : 8,
    "name": "Muñequería y peluches"
  },
  {
    "id" : 8,
    "name": "Madera y cartón"
  },
  {
    "id" : 8,
    "name": "Decoupage"
  },
  {
    "id" : 8,
    "name": "Goma eva y fofuchas"
  }
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
                  Container(
                      child:Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.view_headline_sharp,
                              color: azul_logo,
                            ),
                            onPressed: () {
                            },
                          ).paddingLeft(10),

                          IconButton(
                            icon: const Icon(
                              Icons.person,
                              color: azul_logo,
                            ),
                            onPressed: () {
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_to_photos,
                              color: azul_logo,
                            ),
                            onPressed: () {
                            },
                          ),
                        ],
                      )
                  ),
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
                                      width: 1.0,
                                      color: azul_logo
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