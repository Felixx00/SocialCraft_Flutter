import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/materiales.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:smart_select/smart_select.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SubirPasos extends StatefulWidget {
  static String tag = '/upload';
  var map = Map<String, dynamic>();
  SubirPasos(this.map);
  @override
  SubirPasosState createState() => SubirPasosState();
}

class SubirPasosState extends State<SubirPasos> {
  File imageFile;
  @override
  void initState() {
    super.initState();
    init();
  }

  var map2 = Map<String, dynamic>();
  String token = "";
  var objeto_foto;

  init() async {
    map2 = widget.map;
    objeto_foto = map2['rutaFoto'];
    map2['rutaFoto'] = 'placeholder';
    mapfoto['rutaFoto'] = "";
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    print(map2);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String fotopasoeditar = "";

  int activeStep = 0;
  final controller = TextEditingController(text: "");
  final controller2 = TextEditingController(text: "");

  int upperBound = 1;
  List<int> numb = [1];
  List<String> textos = ["", "", "", "", "", "", "", "", "", ""];
  List<String> descripciones = ["", "", "", "", "", "", "", "", "", ""];
  List<PickedFile> imagenes = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null
  ];

  var mapfoto = Map<String, dynamic>();

  Future<Resp> subirTuto() async {
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'tutorials/uploadTutorial'),
      body: map2,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      print('tuto bien');
      return Resp.fromJson3(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future<Resp> subirPasos(int id, int numeropaso) async {
    await subirfotopaso(id, (numeropaso + 1));
    var map3 = new Map<String, dynamic>();
    map3['IdTutorial'] = id.toString();
    map3['NumPaso'] = numeropaso.toString();
    map3['Text'] = descripciones[numeropaso];
    map3['RutaFoto'] = fotopasoeditar;
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'tutorials/uploadStep'),
      body: map3,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);

      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  void subirfoto(int x) async {
    var foto = objeto_foto;
    Navigator.pop(context);
    print(foto);

    if (foto != null) {
      final _firebaseStorage = FirebaseStorage.instance;
      var file = File(objeto_foto.path);
      print('oooo');
      print(file);
      print('aaaaa');
      await _firebaseStorage
          .ref()
          .child('Posts/' + x.toString() + '/principal')
          .putFile(file);

      var ref =
          _firebaseStorage.ref().child("Posts/" + x.toString() + '/principal');
      mapfoto['rutaFoto'] = (await ref.getDownloadURL()).toString();
      print('eeee' + mapfoto['rutaFoto']);
      mapfoto['tutId'] = x.toString();
      cambios();

      //print(foto.path);
    } else {
      print('No image selected.');
    }
  }

  Future<Resp> cambios() async {
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/editTutorial'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: mapfoto,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.modificar(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  Future subirfotopaso(int x, int idpaso) async {
    if (imagenes[idpaso - 1] != null) {
      final _firebaseStorage = FirebaseStorage.instance;
      var file = File(imagenes[idpaso - 1].path);
      print(file);
      print('aaaaaaaaaaaaaaa');
      await _firebaseStorage
          .ref()
          .child('Posts/' + x.toString() + '/paso' + idpaso.toString())
          .putFile(file);
      var ref = FirebaseStorage.instance
          .ref()
          .child('Posts/' + x.toString() + '/paso' + idpaso.toString());
      fotopasoeditar = (await ref.getDownloadURL()).toString();
      Future a;
      return a;
      //print(foto.path);
    } else {
      print('No image selected.');
    }
  }
  Future<Resp> getcategorias() async {
    final response = await http.get(
      Uri.https('api.socialcraft.club', 'tutorials/getCategories'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.fromJson2(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }
  _openGallery(BuildContext context) async{
    imagenes[activeStep] = await ImagePicker().getImage(source: ImageSource.gallery);
    setState((){
      if (imagenes[activeStep] != null){
        imageFile = File(imagenes[activeStep].path);
      }
      else {
      }
    });
    Navigator.of(context).pop();
  }

  _openCamara(BuildContext context)async{
    imagenes[activeStep] = await ImagePicker().getImage(source: ImageSource.camera);
    setState((){
      if (imagenes[activeStep] != null){
        imageFile = File(imagenes[activeStep].path);
      }
      else {
      }
    });
    Navigator.of(context).pop();
  }
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Selecionar"),
        content: SingleChildScrollView(
            child:ListBody(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.photo_library_outlined,
                        color: azul_logo,
                        size: 30.0,
                        semanticLabel:
                        'Text to announce in accessibility modes',
                      ).paddingAll(20),
                      GestureDetector(
                          child: Text("Galeria"),
                          onTap: (){
                            _openGallery(context);
                          }
                      ),
                    ],
                  ),
                  //Padding(padding: EdgeInsets.all(8.0)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_a_photo_rounded,
                        color: azul_logo,
                        size: 30.0,
                        semanticLabel:
                        'Text to announce in accessibility modes',
                      ).paddingAll(20),
                      GestureDetector(
                          child: Text("Cámara"),
                          onTap: (){
                            _openCamara(context);
                          }
                      ),
                    ],
                  ),
                ]
            )

        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Subir pasos'),
        backgroundColor: azul_logo,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: OutlinedButton.icon(
              label:
                  Text('Subir', style: primaryTextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(color: Colors.white, width: 1.5),
              ),
              icon: Icon(Icons.cloud_upload_outlined),
              onPressed: () async {
                bool vacio = false;
                for (int i = 0; i < upperBound && !vacio; ++i) {
                  if (descripciones[i] == "") {
                    vacio = true;
                    toast("Existe Step Vacío", bgColor: toast_color);
                  }
                }
                if (!vacio) {
                  await subirTuto().then((respuesta) async {
                    if (respuesta.success == false) {
                      setState(() {});
                      toast("Incorrecto", bgColor: toast_color);
                    } else {
                      print(respuesta.id);
                      for (int i = 0; i < upperBound; i++) {
                        subirPasos(respuesta.id, i);
                      }

                      subirfoto(respuesta.id);
                      print(mapfoto);
                      Navigator.pushNamedAndRemoveUntil(
                          context, 'barra', (Route<dynamic> route) => false);
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              NumberStepper(
                numbers: numb,

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                    controller.text = textos[activeStep];
                    controller2.text = descripciones[activeStep];
                  });
                },
              ),
              30.height,
              header(),
              //Text((activeStep + 1).toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
              20.height,
              ElevatedButton(
                child: Text('Selecciona Imagen'),
                style: ElevatedButton.styleFrom(
                  //minimumSize: Size(150, 40),
                  //primary: Colors.lightBlueAccent[200],
                  primary: azul_logo,
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                ),
                onPressed: () async {
                  _showChoiceDialog(context);
                  /*imagenes[activeStep] =
                      await ImagePicker().getImage(source: ImageSource.gallery);*/
                  print(imagenes);
                },
              ),
              16.height,
              IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 35,
                  color: Colors.redAccent[200],
                  onPressed: () {
                    imagenes[activeStep] = null;
                  }),
              90.height,
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        if (numb.length > 1) {
                          upperBound -= 1;
                          controller.text = "";
                          numb.remove(activeStep + 1);
                          for (int i = activeStep; i < numb.length + 1; ++i) {
                            if (i < numb.length) {
                              numb[i] = numb[i] - 1;
                              descripciones[i] = descripciones[i + 1];
                            } else
                              descripciones[i] = "";
                            if (i != numb.length)
                              imagenes[i] = imagenes[i + 1];
                            else
                              imagenes[i] = null;
                          }
                          if (activeStep != numb.length)
                            controller2.text = descripciones[activeStep];
                          else
                            controller2.text = descripciones[activeStep - 1];
                          if (activeStep == numb.length)
                            activeStep = activeStep - 1;
                          print(descripciones);
                          setState(() {});
                        }
                      },
                      label: Text(
                        'Step',
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.remove),
                      backgroundColor: azul_logo,
                    ).paddingLeft(10),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        print(descripciones);
                        if (numb.length < 10) {
                          upperBound += 1;
                          controller.text = "";
                          controller2.text = "";
                          activeStep = numb.length;
                          numb.add(numb.length + 1);
                          setState(() {});
                        }
                      },
                      label: Text(
                        'Step',
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.add),
                      backgroundColor: azul_logo,
                    ).paddingRight(10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Column(
      children: [
        /*
        Container(
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.name,
            cursorColor: azul_logo,
            decoration: InputDecoration(
              //icon: Icon(Icons.search, color: azul_logo),
              border: InputBorder.none,
              hintText: 'Step ' + (activeStep + 1).toString(),
            ),
            onChanged: (newValue) {
              textos[activeStep] = newValue;
            },
          ).paddingLeft(10),
        )
            .cornerRadiusWithClipRRect(12)
            .paddingOnly(top: 30, left: 30, right: 30),*/
        Container(
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: TextFormField(
            controller: controller2,
            keyboardType: TextInputType.name,
            cursorColor: azul_logo,
            maxLines: 10,
            decoration: InputDecoration(
              //icon: Icon(Icons.search, color: azul_logo),
              border: InputBorder.none,
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: "Añade una descripción ...",
            ),
            onChanged: (newValue) {
              descripciones[activeStep] = newValue;
            },
          ).paddingLeft(10),
        )
            .cornerRadiusWithClipRRect(12)
            .paddingOnly(top: 30, left: 30, right: 30),
      ],
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}
