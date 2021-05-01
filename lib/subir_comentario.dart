import 'dart:convert';
import 'package:flutter/material.dart';
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
  SubirComentarioState createState() => SubirComentarioState();
}

class SubirComentarioState extends State<SubirComentario> {
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

              //fer el push comments
              //canviar el navigator perq torni al post_comments
              Navigator.pushNamedAndRemoveUntil(
                  context, 'barra', (Route<dynamic> route) => false);
            }
          )

        ],
        backgroundColor: azul_logo,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Valoración:',style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: azul_logo,
                    fontSize: 20,
                    //fontWeight: FontWeight.w800
                )
            )
            ),
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
                print(rating);
              }
            ),
            Text('Comentario:',style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                  color: azul_logo,
                  fontSize: 20,
                  //fontWeight: FontWeight.w800
                )
            )
            ),
          ]
        )
      )
    );
  }
}
