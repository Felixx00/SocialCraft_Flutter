import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;

class Post extends StatefulWidget {
  @override
  PostState createState() => PostState();
}

class PostState extends State<Post> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget("", color: Colors.white, elevation: 0, actions: [
          IconButton(
              icon: Icon(Icons.local_grocery_store_outlined),
              color: azul_logo,
              onPressed: () {}),
        ]),
        persistentFooterButtons: [
          Container(
            width: context.width(),
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          )
        ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Titulo Post", style: boldTextStyle(size: 32)),
              8.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Categoria", style: secondaryTextStyle()),
                      2.height,
                      Text("Manualidades", style: boldTextStyle()),
                      16.height,
                      Text("Dificultad", style: secondaryTextStyle()),
                      2.height,
                      Text("Facil", style: boldTextStyle()),
                      16.height,
                      Text("Duracion", style: secondaryTextStyle()),
                      2.height,
                      Text("30min", style: boldTextStyle()),
                    ],
                  ),
                  24.width,
                  Image.network('https://picsum.photos/250?image=9'),
                ],
              ),
              32.height,
              Text("Descripcion", style: boldTextStyle(size: 20)),
              8.height,
              Text(
                "Hola hola hola hola como estas. ",
                style: secondaryTextStyle(),
              ),
              32.height,
              /*
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: EGPrimaryColor3,
                        child: Icon(Icons.brightness_5,
                            color: egPrimaryColor1, size: 18)),
                    12.width,
                    createRichText([
                      TextSpan(text: "Sun\n", style: secondaryTextStyle()),
                      TextSpan(text: "8hrs", style: boldTextStyle()),
                    ]),
                    32.width,
                    CircleAvatar(
                        backgroundColor: EGPrimaryColor3,
                        child: Icon(MaterialCommunityIcons.water,
                            color: egPrimaryColor1, size: 18)),
                    12.width,
                    createRichText([
                      TextSpan(text: "Water\n", style: secondaryTextStyle()),
                      TextSpan(text: "2 days", style: boldTextStyle()),
                    ]),
                    32.width,
                    CircleAvatar(
                        backgroundColor: EGPrimaryColor3,
                        child: Icon(AntDesign.hearto,
                            color: egPrimaryColor1, size: 18)),
                    12.width,
                    createRichText([
                      TextSpan(text: "Lifetime\n", style: secondaryTextStyle()),
                      TextSpan(text: "7 months", style: boldTextStyle()),
                    ]),
                    32.width,
                    CircleAvatar(
                        backgroundColor: EGPrimaryColor3,
                        child: Icon(MaterialCommunityIcons.leaf,
                            color: egPrimaryColor1, size: 18)),
                    12.width,
                    createRichText([
                      TextSpan(text: "Sprouts\n", style: secondaryTextStyle()),
                      TextSpan(text: "7 days", style: boldTextStyle()),
                    ]),
                  ],
                ),
              ),
              */
              16.height,
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
