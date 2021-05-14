import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/post.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'subir_comentario.dart';


class PostComentarios extends StatefulWidget {
  final String tutId;
  PostComentarios(this.tutId);

  @override
  PostComentariosState createState() => PostComentariosState();
}

String token = "";
List<dynamic> comentarios = [];
String rutaFoto = "https://www.labicok.com/wp-content/uploads/2020/06/default-user-image.png" ;

class PostComentariosState extends State<PostComentarios> {
  @override
  initState() {
    super.initState();
    init();
    setState(() {});
  }

  init() async {
    String idTut = widget.tutId;
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');

    getComments(idTut).then((respuesta) async {
      comentarios = respuesta.list;
      setState(() {});
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<Resp> getComments(String tutId) async {
    var map = new Map<String, dynamic>();
    map['tutId'] = tutId;
    map['limit'] = "100";
    map['offset'] = "0";
    final response = await http.get(
      Uri.https('api.socialcraft.club', '/tutorials/getComments', map),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    String idTut = widget.tutId;
    double val;
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: () => init(),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: comentarios.length,
              itemBuilder: (context,i) => new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      comentarios[i]['fotoPerfil'] == null ? rutaFoto:comentarios[i]['fotoPerfil'])),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: comentarios[i]['username'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.0,
                                                    color: Colors.black),
                                                ),
                                                /*TextSpan(
                                                  text: " · ${comentarios[i]['datahora']}",
                                                  style: TextStyle(
                                                    fontSize: 14.0, color: Colors.grey))*/
                                              ]),
                                              //overflow: TextOverflow.ellipsis,
                                            )),
                                            flex: 1,
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment(0.5,0.5),
                                                child: RatingBar.builder(
                                                  itemCount: 5,
                                                  itemSize: 27,
                                                  allowHalfRating: true,
                                                  ignoreGestures: true,
                                                  initialRating: double.parse(comentarios[i]['valoracion']),
                                                  itemBuilder: (context,_){
                                                    return Icon(Icons.star, color: Colors.amber);
                                                  },
                                                  onRatingUpdate: null,
                                                ),
                                              ),
                                            ),
                                      ],
                                    ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        comentarios[i]['texto'],
                                        style: TextStyle(fontSize: 15.0),
                                      )
                                  ),
                                ),
                                comentarios[i]['fotografia'] == null ?
                                Container() : Container(
                                  height:  300.0,
                                  width: 300.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            comentarios[i]['fotografia'])),
                                  ),
                                ).paddingOnly(top: 5, bottom: 5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: comentarios[i]['datahora'],
                                          style: TextStyle(
                                              fontSize: 12.5,
                                              color: Colors.grey)
                                      )
                                    ]),
                                )
                                ),],
                            ),
                        )
                      ],
                    ),
                  )
                ],
              ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        heroTag: '1',
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubirComentario(idTut),
            ),
          );
        },
        backgroundColor: azul_logo,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}