// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';

void main() => runApp(Register());
FocusNode nameNode;
class Register extends StatelessWidget {
  String name = "";
  String user = "";
  String pwd = "";
  String mail = "";
  String direction = "";
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SocialCraft'),
        ),
        body: Center(
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child:Center(
                child: Column(
                  children: [
                    Container(
                        child: Image.asset(socialcraft_logo_letras,
                            width: 200, height: 200),
                    ).cornerRadiusWithClipRRect(16).paddingTop(50),/*
                    Container(
                      child: Image.asset(socialcraft_logo_letras,
                          width: 300, height: 100),
                    ).cornerRadiusWithClipRRect(16).paddingTop(50),*/
                    //Text("SocialCraft", style: boldTextStyle(size: 32)),
                  ],
                ),
              ),
            ),
          Container(
              padding: EdgeInsets.only(left:20.0, right:20.0),
              child: Column(
                children: <Widget> [
                  Container(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child:TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.portrait),
                      border: InputBorder.none,
                      hintText: "Nombre",
                    ),
                    controller: myController,

                    ).paddingOnly(left: 8, top: 2),
                  ).cornerRadiusWithClipRRect(12)
                    .paddingOnly( bottom: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child:TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Nombre de Usuario",
                      ),
                      onSaved: (newValue) {
                        user = newValue;
                      },
                    ).paddingOnly(left: 8, top: 2),
                  ).cornerRadiusWithClipRRect(12)
                    .paddingOnly(top: 8, bottom: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child:TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Contraseña",
                      ),
                      onSaved: (newValue) {
                      pwd = newValue;
                    },
                    ).paddingOnly(left: 8, top: 2),
                  ).cornerRadiusWithClipRRect(12)
                      .paddingOnly(top: 8, bottom: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child:TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Repetir Contraseña",
                      ),
                      onSaved: (newValue) {
                        //pwd2 = newValue;
                      },
                    ).paddingOnly(left: 8, top: 2),
                  ).cornerRadiusWithClipRRect(12)
                      .paddingOnly(top: 8, bottom: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child:TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                      onSaved: (newValue) {
                        mail = newValue;
                      },
                    ).paddingOnly(left: 8, top: 2),
                  ).cornerRadiusWithClipRRect(12)
                      .paddingOnly(top: 8, bottom: 8),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child:TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_on),
                        border: InputBorder.none,
                        hintText: "Dirección",
                      ),
                      onSaved: (newValue) {
                        direction = newValue;
                      },
                    ).paddingOnly(left: 8, top: 2),
                  ).cornerRadiusWithClipRRect(12)
                      .paddingOnly(top: 8, bottom: 8),

                  Container(
                      padding: EdgeInsets.only(top:10),
                      height: 53.0,
                      child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blueAccent,
                      color: Colors.blue,
                      elevation: 7.0,
                      child: GestureDetector(
                          onTap: () {
                            return showDialog(
                              context: context,
                              // ignore: missing_return
                              builder: (context) {
                                print(myController.text);
                               return Text(myController.text);
                              },

                            );
                          },
                        child: Center(
                          child: Text(
                            'Registrar',
                            style: TextStyle(
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'
                            ),
                          ),
                        )
                      )
                    )
                  )
                ],
              )
            )
          ],
        ),
      ),
      ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}





