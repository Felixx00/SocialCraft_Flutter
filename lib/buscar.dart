import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_select/smart_select.dart';
import 'package:socialcraft/perfil2.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:socialcraft/utils/images.dart';


/*class IdUsuario{
  int idUsuario;
  IdUsuario(this.idUsuario);
}*/

void main() => runApp(Search());
FocusNode nameNode;

class Search extends StatefulWidget {
  @override
  SearchW createState() => SearchW();
}

String userName;
String token = '';
String busqueda = "";
var linkFoto = "";
bool one = true;
var users=[];
var usersL=[];
var tutorials = [];
int user;
String nombre= "";
String rutaFoto = "https://icons555.com/images/icons-gray/image_icon_user_4_pic_512x512.png";
bool followed= true;
List infoBusqueda = [];
bool unfollow= true;
var myself;
List categories= [];
List userss = [
  {
    "id" : 0,
    "nombre" : "",
    "username" : "",
    "rutaFoto": socialcraft_logo,
    "followed": false
  },
];

String value1 = 'flutter';
List<S2Choice<String>> options = [
  S2Choice<String>(value: '1', title: 'Título'),
  S2Choice<String>(value: '2', title: 'Duración'),
  S2Choice<String>(value: '3', title: 'Dificultad'),
];

class SearchW extends State<Search> {
  String _idUser = "";
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    listCategories().then((response) async {
      categories = response.list;
    });
    Myself().then((response) async {
      myself = response.data['username'];
      setState(() {});
      print(myself);
    });
    await Firebase.initializeApp();
    value1 = "";

  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  Imagenes(String userName){
    if(users != null || userName != ""){
      getImage(userName);
    }
  }
  Future getImage(String userName) async {
    var r = FirebaseStorage.instance.ref(userName + '/image');
    try {
      await r.getDownloadURL();
      var ref = FirebaseStorage.instance.ref().child(userName + '/image');
      linkfoto = (await ref.getDownloadURL()).toString();
    } catch (err) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('Usuario_Default/default-user-image.png');
      linkfoto = (await ref.getDownloadURL()).toString();
    }
  }

  Future<Resp> Myself() async {
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

  Future<Resp> listSearchUser(String busqueda) async {
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
  Future<Resp> listSearchTitle(String busqueda) async {
    var map = new Map<String, dynamic>();
    map['title'] = busqueda;
    map['limit'] = '500';
    map['offset'] = '0';
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/searchTitle'),
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
  Future<Resp> listSearchDuration(String busqueda) async {
    var map = new Map<String, dynamic>();
    map['duration'] = busqueda;
    map['limit'] = '500';
    map['offset'] = '0';
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/searchDuration'),
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
  Future<Resp> listSearchDifficulty(String busqueda) async {
    var map = new Map<String, dynamic>();
    map['diff'] = busqueda;
    map['limit'] = '500';
    map['offset'] = '0';
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/searchDifficulty'),
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

  Future<Resp> followUser(String id) async {
    var map = new Map<String, dynamic>();
    map['userId'] = id;
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/users/followUser'),
      body: map,
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

  Future<Resp> unfollowUser(String id) async {
      var map = new Map<String, dynamic>();
      map['userId'] = id;
      final response = await http.post(
        Uri.https('api.socialcraft.club', '/users/unfollowUser'),
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

  Future<Resp> followCategory(String idCat) async {
    var map = new Map<String, dynamic>();
    map['catId'] = idCat;
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/followCategory'),
      body: map,
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

  Future<Resp> unfollowCategory(String idCat) async {
    var map = new Map<String, dynamic>();
    map['catId'] = idCat;
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/unfollowCategory'),
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

  @override
  Widget build(BuildContext context) {
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
                        onChanged: (texto) {
                          busqueda = texto;
                          if (busqueda.length >= 3) {
                            if (value1 == "Título") {
                              listSearchTitle(busqueda).then((response) async {
                                tutorials = response.list;
                                //tutorials = usersL;
                                setState(() {});
                                print(tutorials.length);
                                if (response.list == null ||
                                    tutorials.length == null) {}
                              });
                            }
                            else if (value1 == "Duración") {
                              listSearchDuration(busqueda).then((response) async {
                                tutorials = response.list;
                                //users = usersL;
                                setState(() {});
                                print(tutorials.length);
                                if (response.list == null ||
                                    tutorials.length == null) {}
                              });
                            }
                            else if (value1 == "Dificultad") {
                              listSearchDifficulty(busqueda).then((response) async {
                                tutorials = response.list;
                                //users = usersL;
                                setState(() {});
                                print(tutorials.length);
                                if (response.list == null ||
                                    tutorials.length == null) {}
                              });
                            }
                            else {
                              listSearchUser(busqueda).then((response) async {
                                usersL = response.list;
                                users = usersL;
                                setState(() {});
                                print(users.length);
                                if (response.list == null ||
                                    users.length == null) {}
                              }
                              );
                            }
                          }
                          else {
                            users = userss;
                            print(users.length);
                            setState(() {});
                          };
                        },
                      ).paddingLeft(10),
                  ).cornerRadiusWithClipRRect(12).paddingOnly(top:70, left:20, right: 20, bottom:50),
                    bottom: TabBar(
                      indicatorColor: Colors.grey[300],
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: <Widget>[
                        Tab(icon: Icon(
                          Icons.video_library_rounded,
                          //Icons.view_headline_sharp,
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
                              child:Column(
                                  children: [
                                    SmartSelect<String>.single(
                                        tileBuilder: (context, state) {
                                          return S2Tile(
                                            title: state.titleWidget,
                                            leading: Icon(Icons.filter_alt),
                                            value: state.valueDisplay,
                                            onTap: state.showModal,
                                            isLoading: false,
                                          );
                                        },
                                        modalConfig: S2ModalConfig(
                                          type: S2ModalType.popupDialog,
                                          style: S2ModalStyle(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        modalHeaderStyle: S2ModalHeaderStyle(
                                            backgroundColor: azul_logo,
                                            textStyle: TextStyle(color: white)),
                                        title: 'Filtra videos',
                                        value: value1,
                                        choiceItems: options,
                                        onChange: (state) => setState(() => value1 = state.value),
                                     ),
                                    Divider(
                                      height: 10,
                                      thickness: 3,
                                      color: Colors.grey[650],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(children: List.generate(tutorials.length,(index) {
                                            //if (users.length != null || users[index]["username"] != null) Imagenes(users[index]["username"]);
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 1,
                                                  bottom: 1),
                                              child: Column(
                                                children: <Widget>[
                                                  ListTile(
                                                      title: TextButton(
                                                          child:Text(
                                                            nombre = tutorials[index]["titulo"],
                                                            semanticsLabel: "titulo",
                                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                          ),
                                                          onPressed: () {
                                                              /*_idUser = users[index]["id"];
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => Perfil2(_idUser),
                                                                ),
                                                              ).then((value) => setState(() {}));*/
                                                            }
                                                      ),
                                                      leading: Container(
                                                        height: 50.0,
                                                        width: 50.0,
                                                        decoration: new BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          //Imagenes(users[index]["username"]),
                                                          image: new DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: new NetworkImage(
                                                                  rutaFoto)),
                                                        ),
                                                      ).paddingOnly(top: 5, bottom: 5),

                                                      /*trailing:
                                                      (myself == users[index]["username"])
                                                          ? IconButton(icon:Icon(Icons.more_vert),
                                                        onPressed: () {
                                                          Navigator.pushNamed(context, "editar");
                                                        },
                                                      )
                                                          :IconButton(
                                                        icon: busqueda.length <3? Icon(Icons.person_add, color: white,): Icon(users[index]["followed"]
                                                            ? Icons.person_add_disabled
                                                            : Icons.person_add,
                                                            size: 18,
                                                            color: users[index]["followed"]
                                                                ? Colors.red[600]
                                                                : azul_logo),
                                                        onPressed: () {
                                                          if(users[index]["followed"] == false) {
                                                            followUser(users[index]["id"]).then((response) async {
                                                              users[index]["followed"] = !users[index]["followed"];
                                                              setState(() {});
                                                            });
                                                          }
                                                          else {
                                                            unfollowUser(users[index]["id"]).then((response) async {
                                                              users[index]["followed"] = !users[index]["followed"];
                                                              setState(() {});
                                                            });
                                                          }
                                                        },
                                                      )*/
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ),
              ],
                      )),
                      SingleChildScrollView(
                        child:Column(
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: List.generate(users.length,(index) {
                                //if (users.length != null || users[index]["username"] != null) Imagenes(users[index]["username"]);
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
                                                if(myself == users[index]["username"]){
                                                  Navigator.pushNamed(context, "perfil");
                                                }
                                                else{
                                                  _idUser = users[index]["id"];
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Perfil2(_idUser),
                                                    ),
                                                  ).then((value) => setState(() {}));

                                                }

                                              }
                                          ),
                                        leading: Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            //Imagenes(users[index]["username"]),
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                    rutaFoto)),
                                          ),
                                        ).paddingOnly(top: 5, bottom: 5),

                                        trailing:
                                        (myself == users[index]["username"])
                                          ? IconButton(icon:Icon(Icons.more_vert),
                                            onPressed: () {
                                              Navigator.pushNamed(context, "editar");
                                            },
                                          )
                                            :IconButton(
                                          icon: busqueda.length <3? Icon(Icons.person_add, color: white,): Icon(users[index]["followed"]
                                              ? Icons.person_add_disabled
                                              : Icons.person_add,
                                              size: 18,
                                              color: users[index]["followed"]
                                                  ? Colors.red[600]
                                                  : azul_logo),
                                          onPressed: () {
                                            if(users[index]["followed"] == false) {
                                              followUser(users[index]["id"]).then((response) async {
                                                users[index]["followed"] = !users[index]["followed"];
                                                setState(() {});
                                              });
                                            }
                                            else {
                                              unfollowUser(users[index]["id"]).then((response) async {
                                                users[index]["followed"] = !users[index]["followed"];
                                                setState(() {});
                                              });
                                            }
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
                          ],
                        ),
                  ),
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
                                            trailing: ElevatedButton.icon(
                                              label: Text(categories[index]["seguido"] ? 'Follow': 'Unfollow'),
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(50,40),
                                                primary: categories[index]["seguido"] ? Color.fromRGBO(68,102,216,1.0) : Colors.redAccent[200],
                                                onPrimary: Colors.white,
                                                onSurface: Colors.grey,
                                              ),
                                              icon: Icon(categories[index]["seguido"] ? Icons.person_add : Icons.person_add_disabled, size: 18),
                                              onPressed: () {
                                                if(categories[index]["seguido"] == false) {
                                                  followCategory(categories[index]["id"]).then((response) async {
                                                    categories[index]["seguido"] = !categories[index]["seguido"];
                                                    setState(() {});
                                                  });
                                                }
                                                else {
                                                  unfollowCategory(categories[index]["id"]).then((response) async {
                                                    categories[index]["seguido"] = !categories[index]["seguido"];
                                                    setState(() {});
                                                  });
                                                }
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
                  )
                    ]
              )
          ),
      )
  );

}
}