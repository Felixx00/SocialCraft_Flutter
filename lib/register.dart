// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';

void main() => runApp(Register());
FocusNode nameNode;
class Register extends StatelessWidget {

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
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                      child: Image.asset(socialcraft_logo,
                          width: 100, height: 100),
                    ),
                  ).cornerRadiusWithClipRRect(16).paddingTop(50),/*
                  Container(
                    child: Image.asset(socialcraft_logo_letras,
                        width: 300, height: 100),
                  ).cornerRadiusWithClipRRect(16).paddingTop(50),*/
                  //Text("SocialCraft", style: boldTextStyle(size: 32)),
                ],
              ),
            ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(130, 20, 0, 0),
                    child: ClipOval(
                        child:Material(
                          child: InkWell(
                            child: SizedBox(
                              width: 34, height: 34 ,
                                child: Image.asset(google_logo, width: 25, height: 25),
                            )
                                ),
                              ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: ClipOval(
                      child:Material(
                        child: InkWell(
                            child: SizedBox(
                              width: 34, height: 34 ,
                              child: Image.asset(facebook_logo, width: 25, height: 25),
                            )
                        ),
                      ),
                    ),
                  ),
                ]
              ),

            Container(
              padding: EdgeInsets.only(top:35.0, left:20.0, right:20.0),
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
                        onTap: (){},
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





