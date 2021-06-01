import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/post.dart';
import 'package:socialcraft/post2.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

String token = "";
List<dynamic> posts = [];
bool empty = false;

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');

    await getTutorials().then((respuesta) async {
      posts = respuesta.list;
      //setState(() {});
    });
    if (posts.length == 0) {
      empty = true;
    } else {
      empty = false;
    }
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<Resp> getTutorials() async {
    var map = new Map<String, dynamic>();
    map['limit'] = "100";
    map['offset'] = "0";
    final response = await http.get(
      Uri.https('api.socialcraft.club', '/tutorials/getTutorials', map),
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
    if (empty) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Image.asset(socialcraft_logo_letras_blanco,
                width: 250, height: 250),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: azul_logo,
          ),
          body: Container(
              child: Column(
            children: [
              Text(AppLocalizations.of(context).aunNoSiguesANadie,
                      style: TextStyle(color: azul_logo, fontSize: 27),
                      textAlign: TextAlign.center)
                  .paddingOnly(top: 200, right: 30, left: 30, bottom: 30),
              Icon(
                Icons.search,
                size: 200,
                color: azul_logo,
              ),
            ],
          )),
        ),
      );
    } else {
      return SafeArea(
        child: RefreshIndicator(
          onRefresh: () => init(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Image.asset(socialcraft_logo_letras_blanco,
                  width: 250, height: 250),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: azul_logo,
            ),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(fondo),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 1, bottom: 1),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: targetaTutorial(
                              context,
                              posts[index]["fotoRuta"],
                              posts[index]["titulo"],
                              posts[index]["creador"],
                              posts[index]["rate"],
                              posts[index]["subtitulo"],
                              posts[index]['id'],
                              posts[index]['idCreador']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
  }
}
