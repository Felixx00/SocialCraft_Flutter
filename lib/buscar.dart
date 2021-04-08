import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:socialcraft/utils/images.dart';

void main() => runApp(Search());
FocusNode nameNode;

class Search extends StatefulWidget {
  @override
  SearchW createState() => SearchW();
}
class SearchW extends State<Search> {

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

  String busqueda = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: azul_logo),
              backgroundColor: Colors.white,
              //appStore.cardColor,
              //iconTheme: IconThemeData(color: appStore.isDarkModeOn ? appBarBackgroundColor : scaffoldColorDark),
              elevation: 0,
              leading: Icon(Icons.arrow_back).onTap(() {
                Navigator.pushNamed(context, "perfil2");
              }),
              title: Text('Buscador', style: boldTextStyle(size: 30,color: azul_logo)),
            ),
          body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      cursorColor: azul_logo,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: azul_logo),
                        border: InputBorder.none,
                        hintText: "Busca",
                      ),
                      onChanged: (texto) {
                        busqueda = texto;
                      },
                    ).paddingLeft(10),
                  ).cornerRadiusWithClipRRect(12).paddingOnly(top: 30, left:30, right: 30),

                    Container(
                      child:Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.view_headline_sharp,
                              color: azul_logo,
                            ),
                            onPressed: () {
                            },
                          ).paddingLeft(30),

                        IconButton(
                          icon: const Icon(
                            Icons.person,
                            color: azul_logo,
                          ),
                          onPressed: () {
                          },
                        ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_to_photos,
                              color: azul_logo,
                            ),
                            onPressed: () {
                            },
                          ),
                      ],
                      )
                    )
                ],
            ),
          ),bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.grey[200],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black38),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop, color: Colors.black38),
              label: 'Tienda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.black38),
              label: 'Perfil',
            ),
          ],
          currentIndex: 1,
          selectedItemColor: azul_logo,
          //onTap:  Navigator.pushNamed(context, "settings");,
        ),
        ),

      debugShowCheckedModeBanner: false,
    );
  }
}