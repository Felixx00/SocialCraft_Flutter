import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeCategory extends StatefulWidget {
  @override
  final String catId;
  HomeCategory(this.catId);
  HomeCategoryState createState() => HomeCategoryState(catId);
}

class HomeCategoryState extends State<HomeCategory> {
  final catId;
  HomeCategoryState(this.catId);
  String token = '';
  List tutoriales = [];

  init()async{
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    getTutCategory().then((response) async{
      tutoriales = response.list;
    });
    await Firebase.initializeApp();
  }
  void initState() {
    super.initState();
    init();
  }

  Future<Resp> getTutCategory() async{
    var arr = new List(1);// creates an empty array of length 5
    // assigning values to all the indices
    arr[0] = catId;
    var map = new Map<String,dynamic>();
    String s = "catId[0]";
    print(token);
    map[s] = catId;
    map['limit'] = (100).toString();
    map['offset'] = (0).toString();
    print(Uri.https('api.socialcraft.club', '/tutorials/searchCategory', map));
    final response = await http.get(
      Uri.https('api.socialcraft.club', '/tutorials/searchCategory',map),
      headers: {
        'Autorization': 'Bearer $token',
      },
    );
    print([catId]);
    print(token);
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
    // TODO: implement build
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Column(
              children: [
                Text(catId,style: boldTextStyle(size: 12, color: black)),
              ]
            ),
          ],
        )
      )

    );
    throw UnimplementedError();
  }
}