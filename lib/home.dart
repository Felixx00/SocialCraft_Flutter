import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool showPassword = false;
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  String user = "";
  String pass = "";
  bool correct = true;
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

  Future<Resp> loginUser(String user, String pass) async {
    var map = new Map<String, dynamic>();
    map['user'] = user;
    map['pass'] = pass;
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'login'),
      body: map,
    );
    if (response.statusCode == 200) {
      return Resp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(socialcraft_logo,
                            width: 100, height: 100),
                      ).cornerRadiusWithClipRRect(16).paddingTop(50),
                      Container(
                        child: Image.asset(socialcraft_logo_letras,
                            width: 300, height: 100),
                      ).cornerRadiusWithClipRRect(16).paddingTop(1),
                      Text("Próximamente",
                          style: TextStyle(color: azul_logo, fontSize: 25))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).paddingOnly(top: 200, left: 16, right: 16),
      ),
    );
  }
}
