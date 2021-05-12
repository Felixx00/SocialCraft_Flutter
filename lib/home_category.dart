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
import 'post.dart';

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

  @override
  initState() {
    super.initState();
    init();
    setState((){});
  }

  init()async{
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    getTutCategory().then((response) async{
      tutoriales = response.list;
      print(tutoriales);
      setState((){});
    });
    await Firebase.initializeApp();
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  /*void initState() {
    super.initState();
    init();
  }*/

  Future<Resp> getTutCategory() async{
    var map = new Map<String,dynamic>();
    map['catId'] = catId;
    map['limit'] = (100).toString();
    map['offset'] = (0).toString();
    print(Uri.https('api.socialcraft.club', '/tutorials/searchCategory', map));
    final response = await http.get(
      Uri.https('api.socialcraft.club', '/tutorials/searchCategory',map),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
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
      body:
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: tutoriales.length,
                  itemBuilder: (context, index){
                    return Card(
                      margin: EdgeInsets.all(16),
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          Post(tutoriales[index]['id']).launch(context);
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16), topRight: Radius.circular(16)
                                ),
                                child: Image.network(tutoriales[index]['fotoRuta'],
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(tutoriales[index]["titulo"],
                                  style: boldTextStyle(size: 20, color: textPrimaryColor)).paddingOnly(left: 16),
                                  Text(tutoriales[index]["creador"],
                                  style: TextStyle(fontSize: 16, color: azul_logo)).paddingOnly(left: 16, right: 16, top: 5),
                                  Text(
                                    tutoriales[index]["rate"],
                                    style: TextStyle(fontSize: 20, color: textPrimaryColor),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Text(tutoriales[index]["tagline"],
                                style: secondaryTextStyle(size: 16, color: textPrimaryColor))
                              ),
                              SizedBox(height: 20),
                            ]
                          )
                        )
                      )
                    );
                  }


                )

    );
    throw UnimplementedError();
  }
}