import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:socialcraft/utils/images.dart';
import 'lista_categorias.dart';


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

      return Scaffold(
        body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScroll) {
                  return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap:true,
                    expandedHeight: 160.0,
                   backgroundColor: azul_logo,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        cursorColor: azul_logo,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search, color: azul_logo),
                          border: InputBorder.none,
                          hintText: "Buscar",
                        ),
                        onChanged: (texto){
                          busqueda = texto;
                        },
                      ).paddingLeft(10),
                  ).cornerRadiusWithClipRRect(12).paddingOnly(top:70, left:20, right: 20),


                    bottom: TabBar(
                      indicatorColor: Colors.grey[300],
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: <Widget>[
                        Tab(icon: Icon(
                          Icons.view_headline_sharp,
                          color: Colors.grey[300],
                        )),
                        Tab(icon: Icon(
                          Icons.person,
                          color: Colors.grey[300],
                        )),
                        Tab(icon: Icon(
                          Icons.add_to_photos,
                          color: Colors.grey[300],
                        ))
                      ]
                    ),
                  )
                  ];
                },
                body: TabBarView(
                    children: <Widget>[
                      Icon(Icons.directions_car,color: azul_logo,),
                      Icon(Icons.directions_transit,color: azul_logo,),
                      ListaCategorias(),

                    ]
                )
            )

        )
    );

  }
}