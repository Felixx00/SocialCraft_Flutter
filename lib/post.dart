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
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: Icon(Icons.arrow_back).onTap(() {
                  finish(context);
                }),
                title: Text(
                  "Titulo Post",
                  style: TextStyle(fontFamily: comfortaa),
                ),
                expandedHeight: 320,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://picsum.photos/250?image=9')),
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(.5),
                    )),
                pinned: true,
                bottom: TabBar(
                  indicatorWeight: 4,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                        child: Text("Ingredientes",
                            style: TextStyle(fontSize: 18))),
                    Tab(child: Text("Pasos", style: TextStyle(fontSize: 18))),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(children: <Widget>[Text("hola"), Text("pantalla2")]),
        ),
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: azul_logo),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.arrow_back).onTap(() {
            finish(context);
          }),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Titulo Post", style: boldTextStyle(size: 32)),
              8.height,
              Text("Hola hola hola hola como estas.",
                  style: secondaryTextStyle(size: 16)),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(Icons.brightness_5, color: azul_logo, size: 18),
                        16.width,
                        Text("Categoria", style: secondaryTextStyle())
                      ]),
                      16.height,
                      Row(children: [
                        Icon(Icons.brightness_5, color: azul_logo, size: 18),
                        16.width,
                        Text("DIficultad", style: secondaryTextStyle())
                      ]),
                      16.height,
                      Row(children: [
                        Icon(Icons.brightness_5, color: azul_logo, size: 18),
                        16.width,
                        Text("Duracion", style: secondaryTextStyle())
                      ]),
                      16.height,
                    ],
                  ),
                  24.width,
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: Image.network('https://picsum.photos/250?image=9'),
                  )
                ],
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
*/
