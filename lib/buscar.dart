import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/perfil2.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:socialcraft/utils/images.dart';
import 'lista_categorias.dart';

/*List categories = [
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
];*/

List categories= [];
List userss = [
{
  "id" : 0,
"nombre" : "",
"rutaFoto": socialcraft_logo,
"followed": false
},
];
class IdUsuario{
  int idUsuario;
  IdUsuario(this.idUsuario);
}

void main() => runApp(Search());
FocusNode nameNode;

class Search extends StatefulWidget {
  @override
  SearchW createState() => SearchW();
}
class SearchW extends State<Search> {
  String _idUser = "";
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
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLnNvY2lhbGNyYWZ0LmNsdWIiLCJpYXQiOjE2MTY2NjY0MjMsInVzZXJJZCI6IjEyIn0.zSfDG1InrzwC9dQWwYbinGyqW27DzpNNnr9bHZw_AvhfKFDPLXeR4Gf6JNw9FhsrmyzyRg0Z5TtngROGglRee8fAIUBAndnNCj10RR6R-TWs71SkZa_3-NKK4Y8LWtNBTJbjgOx_9IGRyL7TmAyliHNBnA7WRImwmF9gLbH0ay-s64VY7y70BW3ez0iasaJrzDTEGJqOcdhWo7eq-3F1fgSOTtW2TGfT-6zOCA7klSPwHdiddrdhmRS5nrXme3tZ-Hb34Lhy7He-Bgg10PFPxS2J7CtVTNR_heUxzXw3TSObtcSqYTiHRmVoJfP4UaDmbWTa7A96-TpjnnZZwj3kYg';

  Future<Resp> listSearchUser(String busqueda) async {
    var limit = 500;
    var offset = 0;
    var map = new Map<String, dynamic>();
    map['username'] = busqueda;
    map['limit'] = '500';
    map['offset'] = '0';
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'users/searchUser'),
      body:map,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }
  Future<Resp> listCategories() async {
    final response = await http.get(
      Uri.https('api.socialcraft.club', '/tutorials/getCategories'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  String busqueda = "";
  bool one = true;
  var users=[];
  var usersL=[];
  int user;
  String nombre= "";
  String rutaFoto = "https://icons555.com/images/icons-gray/image_icon_user_4_pic_512x512.png";
  bool followed= true;
  List infoBusqueda = [];
  bool unfollow= true;
  @override
  Widget build(BuildContext context) {
    listCategories().then((response) async {
      categories = response.list;
    });
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
                          //print("el usuario es: ");
                          //print(users);
                          busqueda = texto;
                          if(busqueda.length >= 3 ){
                            //users= userss;
                            listSearchUser(busqueda).then((response) async {
                             usersL = response.list;
                             //userss.addAll(usersL);
                             users = usersL;
                             setState(() {});
                             print(users.length);
                              if(response.list == null || users.length == null){
                                //users = userss;
                              }
                              //print(users);
                            }
                           );
                          }
                          else if (busqueda.length < 3 /*|| users.length == null*/)
                            users= userss;
                          print(users.length);
                          setState(() {});
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
                        Tab(
                            icon: Icon(
                          Icons.add_to_photos,
                          color: Colors.grey[300],
                            ),
                           )
                      ]
                    ),
                  )
                  ];
                },
                body: TabBarView(
                    children: <Widget>[
                      SingleChildScrollView(
                        child:Column(
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
                                          title: TextButton(
                                              child:Text(
                                                nombre = users[index]["nombre"],
                                                semanticsLabel: "nombre",
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                              ),
                                              onPressed: () {
                                                _idUser = users[index]["id"];
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => Perfil2(_idUser),
                                                  ),
                                                );
                                                //Navigator.pushNamed(context, "perfil2");
                                              }
                                          ),
                                        leading: Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                    busqueda.length < 3? socialcraft_logo: rutaFoto)),
                                          ),
                                        ).paddingOnly(top: 5, bottom: 5),

                                        trailing: IconButton(
                                          icon: busqueda.length <3? Icon(Icons.person_add, color: white,): Icon(users[index]["followed"]
                                              ? Icons.person_add_disabled
                                              : Icons.person_add,
                                              size: 18,
                                              color: users[index]["followed"]
                                                  ? Colors.red[600]
                                                  : azul_logo),
                                          onPressed: () {
                                            users[index]["follow"] = !users[index]["followed"];
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
                  ),

                          Icon(Icons.directions_transit,color: azul_logo,),


                  SingleChildScrollView(
                      child:Column(
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(children: List.generate(categories.length, (index){
                                  print(categories.length);
                                return Padding(
                                    padding: const EdgeInsets.only(right:1,
                                        bottom:1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget> [
                                        ListTile(
                                            title: Text(categories[index]["nombre"],
                                                style: TextStyle(
                                                    color:black,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold)),
                                            leading: CircleAvatar(
                                              child: Text(categories[index]["nombre"][0]),
                                            ),
                                            /*trailing: ElevatedButton.icon(
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
                                            )*/
                                        ),
                                      ],
                                    ));
                              }
                              )
                              )

                          )
                        ]
                      )
                  )]
              )
          )

      )
  );

}
}