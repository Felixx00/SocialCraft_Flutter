import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';

class Upload extends StatefulWidget {
  static String tag = '/settings';

  @override
  UploadState createState() => UploadState();
}

class UploadState extends State<Upload> {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Upload'),
          backgroundColor: azul_logo,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              20.height,
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                dashPattern: [6, 3],
                strokeWidth: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: azul_logo,
                      size: 75.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ).paddingAll(20),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  cursorColor: azul_logo,
                  decoration: InputDecoration(
                    //icon: Icon(Icons.search, color: azul_logo),
                    border: InputBorder.none,
                    hintText: "Título ...",
                  ),
                ).paddingLeft(10),
              )
                  .cornerRadiusWithClipRRect(12)
                  .paddingOnly(top: 30, left: 30, right: 30),
              Container(
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  cursorColor: azul_logo,
                  maxLines: 4,
                  decoration: InputDecoration(
                    //icon: Icon(Icons.search, color: azul_logo),
                    border: InputBorder.none,
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    hintText: "Añade una descripción ...",
                  ),
                ).paddingLeft(10),
              )
                  .cornerRadiusWithClipRRect(12)
                  .paddingOnly(top: 30, left: 30, right: 30),
              30.height,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ELIGE DIFICULTAD',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ).paddingOnly(left: 30),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TIEMPO ESTIMADO',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ).paddingOnly(left: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
