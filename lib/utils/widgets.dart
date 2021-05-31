import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/perfil2.dart';
import 'package:socialcraft/post2.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:http/http.dart' as http;
import '../perfil.dart';
import '../resp.dart';


String token = '';
var myself;

class CommonButton extends StatelessWidget {
  final String buttonName;
  CommonButton(
    this.buttonName,
  );



  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(color: azul_logo),
      width: context.width(),
      child: Text(buttonName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )).center().paddingOnly(top: 16, bottom: 16),
    ).cornerRadiusWithClipRRect(12);
  }
}

Widget targetaTutorial(
    context, linkFoto, titulo, usuario, rate, descripcion, post, idCreador) {
  bool correct = true;
  if (rate == null) correct = false;
  return Card(
    margin: EdgeInsets.all(16),
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Post2(post).launch(context);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),

              //placeholder: AssetImage('assets/loading.gif'),
              //image: NetworkImage(linkFoto),

              child: Image.network(linkFoto,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titulo,
                        style: boldTextStyle(size: 20, color: textPrimaryColor))
                    .paddingOnly(left: 16),

                //Icon(Icons.star_outlined, color: azul_logo, size: 22)
                // .paddingOnly(right: 5),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                InkWell(
                  child: Text("@" + usuario,
                          style: TextStyle(fontSize: 16, color: azul_logo))
                      .paddingOnly(left: 16, right: 16, top: 5),
                  onTap: () {
                    Myself().then((response) async {
                      myself = response.data['username'];
                      print(myself);
                    });
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                            myself == usuario ?
                            Perfil(
                        )
                                :
                            Perfil2(
                              idCreador,
                            ),
                      ),
                    ); //.then((value) => setState(() {}));
                  },
                ),
                Expanded(
                  child: Center(
                    child: Container(
                        child: RatingBar.builder(
                      itemCount: 5,
                      initialRating: double.parse(rate),
                      allowHalfRating: true,
                      itemSize: 20,
                      itemBuilder: (context, _) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: null,
                      ignoreGestures: true,
                    ).paddingOnly(right: 5)),
                  ),
                ),
              ],
            ),
            /*Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(descripcion,
                  style: secondaryTextStyle(size: 16, color: textPrimaryColor)),
            ),*/
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
Future<Resp> Myself() async {
  final storage2 = new FlutterSecureStorage();
  String token = await storage2.read(key: 'jwt');
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
