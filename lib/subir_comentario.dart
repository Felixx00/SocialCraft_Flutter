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

class SubirComentario extends StatefulWidget {
  @override
  final String tutId;
  SubirComentario(this.tutId);
  SubirComentarioState createState() => SubirComentarioState();

}

class SubirComentarioState extends State<SubirComentario> {
  String comentario_text = "";
  double points = 0;
  File imageFile;

  _openGallery(BuildContext context) async{
    final picture  = await ImagePicker().getImage(source: ImageSource.gallery);
    setState((){
      if (picture != null){
        imageFile = File(picture.path);
      }
      else {
      }
    });
    Navigator.of(context).pop();
  }

  _openCamara(BuildContext context)async{
    final picture  = await ImagePicker().getImage(source: ImageSource.camera);
    setState((){
      if (picture != null){
        imageFile = File(picture.path);
      }
      else {
      }
    });
    Navigator.of(context).pop();
  }
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Selecionar",),
        content: SingleChildScrollView(
          child:ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Galeria"),
                onTap: (){
                  _openGallery(context);
                }
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                  child: Text("Cámara"),
                  onTap: (){
                    _openCamara(context);
                  }
              ),
            ]
          )

        ),
      );
    });
  }

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
      appBar: AppBar(
        leading: Icon(Icons.arrow_back).onTap((){
          finish(context);
      }),
        title: Text("Añadir Comentario",
        style: GoogleFonts.comfortaa(
          textStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          )
        )),
        actions: <Widget>[
          OutlinedButton.icon(
            label:
                Text('Subir', style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800
                  )
                )
          ),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              side:BorderSide(color: Colors.white, width: 0.5),
            ),
            icon: const Icon(
              Icons.add_comment
            ),
            onPressed: () async{
              if (points == 0) {
                toast("Rellene la puntuación", bgColor: toast_color);
              }
              else{
                print(points);
                print(comentario_text);
                print(imageFile);
                //fer el push comments
                //canviar el navigator perq torni al post_comments
                Navigator.of(context).pop();
                }
            }
          )

        ],
        backgroundColor: azul_logo,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            20.height,
            Text('Valoración:',style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: azul_logo,
                    fontSize: 20,
                    //fontWeight: FontWeight.w800
                )
            )
            ),
            5.height,
            RatingBar.builder(
              itemCount: 5,
              initialRating:0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemBuilder: (context, _)=> Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating){
                points = rating;
                //print(rating);
              }
            ),
            10.height,
            Text('Comentario:',style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                  color: azul_logo,
                  fontSize: 20,
                  //fontWeight: FontWeight.w800
                ))
            ),
            5.height,
            Container(
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: TextFormField(
                cursorColor: azul_logo,
                autofocus: false,
                textInputAction: TextInputAction.done,
                style: secondaryTextStyle(color: Colors.black),
                onChanged: (newValue) {
                  comentario_text = newValue;
                },
                keyboardType: TextInputType.text,
                maxLines: 8,
                //maxLength: 1000,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Exprese su opinión aquí",
                  hintStyle: secondaryTextStyle(size: 16),
                ),
              ).paddingLeft(8)
            ).cornerRadiusWithClipRRect(12).paddingOnly(top:10, bottom:10),
            10.height,
            imageFile == null ? DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                dashPattern: [8, 8],
                color: azul_logo,
                strokeWidth: 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: azul_logo,
                        size:160.0,
                      ).paddingAll(20),
                    ),
                    )
                )
            :
            DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                dashPattern: [8, 8],
                strokeWidth: 3,
                color: azul_logo,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.file(imageFile, width:200, height: 200,),

                )
            ),
            5.height,
            RaisedButton(
              color:azul_logo,
              onPressed:(){
                _showChoiceDialog(context);
              },child:Text("Select Image", style: TextStyle(color:Colors.white)),
            )

          ]
        )
      )
    );
  }
}
