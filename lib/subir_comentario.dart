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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubirComentario extends StatefulWidget {
  @override
  final String tutId;
  SubirComentario(this.tutId);
  SubirComentarioState createState() => SubirComentarioState(tutId);

}

class SubirComentarioState extends State<SubirComentario> {
  String comentario_text = "";
  double points = 0;
  File imageFile;
  final String tutId;
  SubirComentarioState(this.tutId);
  String token = "";
  String userName ="";
  String desc ="";

  init()async{
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    await Firebase.initializeApp();
    username().then((respuesta) async {
      //print(respuesta.data['name']);
      userName = respuesta.data['username'];

      await Firebase.initializeApp();
      setState(() {});
    });
  }

  Future<Resp> subirComent() async {
    var map = new Map<String,dynamic>();
    map['tutId'] = tutId;
    map['score'] = points.toString();
    map['comment'] = comentario_text;
    map['imagen'] = desc;
    final response = await http.post(
      Uri.https('api.socialcraft.club','tutorials/commentTutorial'),
      body: map,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(map['tutId']);
    print(map['score']);
    print(map['comment']);
    print(map['image']);
    print(response.statusCode);
    print(token);
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson3(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }
  Future<Resp> username() async {
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
        title: Text(AppLocalizations.of(context).selecionar,),
        content: SingleChildScrollView(
          child:ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text(AppLocalizations.of(context).galeria),
                onTap: (){
                  _openGallery(context);
                }
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                  child: Text(AppLocalizations.of(context).camera),
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
        title: Text(AppLocalizations.of(context).anadirValoracion,
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
                Text(AppLocalizations.of(context).subir, style: GoogleFonts.comfortaa(
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
              if (points == 0 || comentario_text =="") {
                toast(AppLocalizations.of(context).camposObligatoriosValoracion, bgColor: toast_color);
              }
              else{
                if (imageFile != null) {
                  var now = DateTime.now();
                  String nows = now.toString();
                  final _firebaseStorage =
                      FirebaseStorage.instance;
                  await _firebaseStorage
                      .ref()
                      .child(
                      'Posts/' + tutId + '/comments/' + userName + '_' + nows)
                      .putFile(imageFile);
                  var ref = FirebaseStorage.instance.ref().child(
                      'Posts/' + tutId + '/comments/' + userName + '_' + nows);
                  desc = (await ref.getDownloadURL()).toString();
                }
                await subirComent().then((respuesta) async{
                  if(respuesta.success == false){
                    setState((){});
                    toast("Incorrecto", bgColor: toast_color);
                  } else {
                    print(respuesta.id);
                  }
                });
                //print(points);
                //print(comentario_text);
                //print(imageFile);
                //print("el següent es el ID del tutorial");
                //print(tutId);
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
            Text(AppLocalizations.of(context).valoracion + ":",style: GoogleFonts.comfortaa(
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
            Text(AppLocalizations.of(context).comentario + ':',style: GoogleFonts.comfortaa(
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
                  hintText: AppLocalizations.of(context).expreseSuOpinionAqui,
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
              },child:Text(AppLocalizations.of(context).seleccionaImagen, style: TextStyle(color:Colors.white)),
            )

          ]
        )
      )
    );
  }
}
