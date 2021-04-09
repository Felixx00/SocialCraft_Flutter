import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:socialcraft/utils/images.dart';

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
    return MaterialApp(
        title: 'Welcome to Flutter',
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
                          ).paddingLeft(30),

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
                    )
                ],
            ),
          )
        ),

      debugShowCheckedModeBanner: false,
    );
  }
}