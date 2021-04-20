import 'dart:convert';
import 'package:flutter/cupertino.dart';
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

  init() async {

  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  Future<Resp> listSearchUser(String busqueda) async {
    var map = new Map<String, dynamic>();
    map['userName'] = busqueda;
    map['limit'] = 500;
    map['offset'] = 0;
    final response = await http.get(
      Uri.https('api.socialcraft.club', 'searchUser'),
    );
    if (response.statusCode == 200) {
      return Resp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  String busqueda = "";
  bool one = true;
  var users=[];
  int user;
  String nombre= "";
  String rutaFoto = "";
  bool followed;
  List infoBusqueda = [];
  bool unfollow= true;
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
   /* if(one){
      one = !one;
      users = listUser();
    }*/
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
                      print("el usuario es: ");
                      print(users);
                      busqueda = texto;
                      if(busqueda.length >= 3){
                        listSearchUser(busqueda).then((respuesta) async {
                          users = respuesta.data as List;
                          setState(() {});
                        });
                        for(var i = 0; i< users.length; ++i){
                          nombre = users[i].nombre;
                          rutaFoto = users[i].rutaFoto;
                          followed = users[i].followed;
                        }
                      }
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
                  scrollDirection: Axis.vertical,
                  child: Column(children: List.generate(3,(index){
                    return Padding(
                      padding: const EdgeInsets.only(right:1,
                          bottom:1),
                      child: Column(
                        children:  <Widget>[
                          Row(children: <Widget>[
                            Container(
                              height: 30.0,
                              width: 40.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(
                                        "https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg")),
                              ),
                            ).paddingOnly(top: 10, bottom: 10, left:20, right: 20),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Taquito González",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(unfollow? Icons.person_add : Icons.person_add_disabled, size: 18,color: unfollow ? azul_logo : Colors.red[600]),
                              onPressed: () {
                                unfollow = !unfollow;
                                setState(() { });
                              },
                            )
                          ],
                          ),
                        ],
                      ),
                    );
                  })),
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