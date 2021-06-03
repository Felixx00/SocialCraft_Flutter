import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'resp.dart';

class Logros extends StatefulWidget {
  static String tag = '/logros';

  @override
  LogrosState createState() => LogrosState();
}

class LogrosState extends State<Logros> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<Resp> challenges() async {
    final response = await http.get(
      Uri.https('api.socialcraft.club', 'challenges/getMyChallenges'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
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

  List<String> lista = [];
  var desafio;

  init() async {
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    await challenges().then((respuesta) async {
      print(respuesta);
      print(respuesta.list.length);
      desafio = respuesta.list[0]['idDesafio'];
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Desafíos'),
          backgroundColor: azul_logo,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(fondo),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                /*
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: 300,
                    height: 405,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: azul_logo,
                            radius: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/c7/80/5e/c7805ee9aa1a16baaa33a7b1be2f220e.png'),
                              radius: 60,
                            ),
                          ),
                          10.height,
                          Text(
                            'Desafío Semanal',
                            style: TextStyle(
                              fontSize: 25,
                              color: azul_logo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.height,
                          Text(
                            'Publica 5 posts',
                            style: TextStyle(
                              fontSize: 15,
                              color: azul_logo,
                            ),
                          ),
                          20.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              new CircularPercentIndicator(
                                radius: 100.0,
                                lineWidth: 10.0,
                                animation: true,
                                percent: 0.6,
                                center: new Text(
                                  "60.0%",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                footer: new Text(
                                  "3/5",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ).paddingTop(8),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: azul_logo,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),*/

                30.height,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: azul_logo,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(trophy2),
                                  radius: 45,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Categorias',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: azul_logo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Sigue 9 categorias',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: azul_logo,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),
                30.height,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: azul_logo,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundImage: desafio != null
                                      ? AssetImage(tick)
                                      : AssetImage(trophy2),
                                  radius: 45,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Comenta',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: azul_logo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Haz 1 comentario',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: azul_logo,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),
                30.height,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: azul_logo,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(trophy2),
                                  radius: 45,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Seguido',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: azul_logo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Ten 10 seguidores',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: azul_logo,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),
                30.height,
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 25,
                  shadowColor: Colors.black,
                  color: Colors.blue[100],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: azul_logo,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(trophy2),
                                  radius: 45,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Seguidor',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: azul_logo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    'Sigue a 20 usuarios',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: azul_logo,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ).center(),
                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
