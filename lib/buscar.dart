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

List categories = [
  {
    "id" : 1,
    "name": "Covid-19",
    "follow": false
  },
  {
    "id" : 2,
    "name": "Patchwork",
    "follow": false
  },
  {
    "id" : 3,
    "name": "Scrapbooking",
    "follow": false
  },
  {
    "id" : 4,
    "name": "Pintura",
    "follow": false
  },
  {
    "id" : 5,
    "name": "Escultura",
    "follow": false
  },
  {
    "id" : 6,
    "name": "Bisutería",
    "follow": false
  },
  {
    "id" : 7,
    "name": "Mercería",
    "follow": false
  },
  {
    "id" : 8,
    "name": "Papelería",
    "follow": false
  },
  {
    "id" : 9,
    "name": "Decoupage",
    "follow": false
  }
];
List users = [
{
  "id" : 1,
"nombre" : "Taquito Gonzalez",
"rutaFoto": "https://cdn.computerhoy.com/sites/navi.axelspringer.es/public/styles/1200/public/media/image/2018/08/fotos-perfil-whatsapp_16.jpg",
"follow": true
},
  {
    "id" : 2,
    "nombre" : "Aaron",
    "rutaFoto": "https://www.mundodeportivo.com/r/GODO/MD/p5/MasQueDeporte/Imagenes/2018/10/24/Recortada/img_femartinez_20181010-125104_imagenes_md_otras_fuentes_captura-kcOG-U452531892714hYG-980x554@MundoDeportivo-Web.JPG",
    "follow": false
  },
  {
    "id" : 3,
    "nombre" : "Botton",
    "rutaFoto": "https://www.satelitemusical.net/sitebuilder/images/billie-eilish-sm-galeria-296x452.jpg",
    "follow": false
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
  //var users=[];
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
                    snap:false,
                    expandedHeight: 150.0,
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
                          print("el usuario es: ");
                          print(users);
                          busqueda = texto;
                          if(busqueda.length >= 3){
                            listSearchUser(busqueda).then((respuesta) async {
                              users = respuesta.data as List;
                              setState(() {});
                            } );

                          }
                        },
                      ).paddingLeft(10),
                  ).cornerRadiusWithClipRRect(12).paddingOnly(top:70, left:20, right: 20, bottom:50),


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
                    children: <Widget> [
                        Column(
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: List.generate(users.length,(index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 1,
                                      bottom: 1),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                    users[index]["rutaFoto"])),
                                          ),
                                        ).paddingOnly(top: 5, bottom: 5),

                                        title: TextButton(
                                            child:Text(
                                              nombre = users[index]["nombre"],
                                              semanticsLabel: "nombre",

                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                            ),
                                          onPressed: () {
                                            Navigator.pushNamed(context, "perfil2");
                                          }
                                        ),
                                        trailing: IconButton(

                                          icon: Icon(users[index]["follow"]
                                              ? Icons.person_add
                                              : Icons.person_add_disabled,
                                              size: 18,
                                              color: users[index]["follow"]
                                                  ? azul_logo
                                                  : Colors.red[600]),
                                          onPressed: () {
                                            users[index]["follow"] = !users[index]["follow"];
                                            setState(() {});
                                          },
                                        )

                                      ),
                                    ],
                                  ),
                                );
                              }
                              ),
                              ),
                              ),
                          ]
                        ),
                          Icon(Icons.directions_transit,color: azul_logo,),
                          Column(
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(children: List.generate(categories.length, (index){
                                return Padding(
                                    padding: const EdgeInsets.only(right:1,
                                        bottom:1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget> [
                                        ListTile(
                                            title: Text(categories[index]["name"],
                                                style: TextStyle(
                                                    color:black,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold)),
                                            leading: CircleAvatar(
                                              child: Text(categories[index]["name"][0]),
                                            ),
                                            trailing: ElevatedButton.icon(
                                              label: Text(categories[index]["follow"] ? 'Follow': 'Unfollow'),
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(50,40),
                                                primary: categories[index]["follow"] ? Color.fromRGBO(68,102,216,1.0) : Colors.redAccent[200],
                                                onPrimary: Colors.white,
                                                onSurface: Colors.grey,
                                              ),
                                              icon: Icon(categories[index]["follow"] ? Icons.person_add : Icons.person_add_disabled, size: 18),
                                              onPressed: () {
                                                categories[index]["follow"] =!categories[index]["follow"];
                                                setState((){});
                                              },
                                            )
                                        ),
                                      ],
                                    ));
                              }
                              )
                              )

                          )
                        ]
                      )
                    ]
                )
            )

        )
    );

  }
}