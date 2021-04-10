import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'post_pasos.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;

import 'post_desc.dart';

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
                        child: Text("Descripción",
                            style: TextStyle(fontSize: 18))),
                    Tab(child: Text("Pasos", style: TextStyle(fontSize: 18))),
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              )
            ];
          },
          body: TabBarView(children: <Widget>[PostDesc(), PostPasos()]),
        ),
      ),
    );
  }
}
