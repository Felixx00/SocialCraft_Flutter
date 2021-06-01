import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/materiales.dart';
import 'dart:convert';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/subir_pasos.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:smart_select/smart_select.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Upload extends StatefulWidget {
  static String tag = '/upload';

  @override
  UploadState createState() => UploadState();
}

class UploadState extends State<Upload> {
  File imageFile;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    value1 = "";
    value2 = "";
    result = "";
    value4 = "";
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    await getcategorias().then((respuesta) async {
      if (respuesta.success == false) {
        toast("Error al cargar", bgColor: toast_color);
      } else {
        print(respuesta.list.length);
        for (int i = 0; i < respuesta.list.length; ++i) {
          categorias.add(
            S2Choice<String>(
                value: respuesta.list[i]['nombre'],
                title: respuesta.list[i]['nombre']),
          );
        }
        //print(respuesta.data['token']);

      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
    final foto  = await ImagePicker().getImage(source: ImageSource.gallery);
    setState((){
      if (foto != null){
        imageFile = File(foto.path);
      }
      else {
      }
    });
    Navigator.of(context).pop();
  }

  _openCamara(BuildContext context)async{
    final foto  = await ImagePicker().getImage(source: ImageSource.camera);
    setState((){
      if (foto != null){
        imageFile = File(foto.path);
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
  String token = "";
  String result = "placeholder";
  bool correct = false;
  String titulo = "";
  String desc = "";
  var foto;

  var map = Map<String, dynamic>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Upload'),
          backgroundColor: azul_logo,
          leading: Icon(Icons.arrow_back).onTap(() {
            Navigator.pop(context);
            //finish(context);
            //Navigator
          }),
        ),
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child:SingleChildScrollView(
          child: Column(
            children: [
              30.height,
              Stack(
                children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: GestureDetector(
                        onTap: () async {
                          _showChoiceDialog(context);
                        },
                        child: imageFile == null ? DottedBorder(
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
                      ),
                    ),
                ],
                clipBehavior: Clip.none,
              ),
              5.height,
              Container(
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: TextFormField(
                  //maxLength: 20,
                  keyboardType: TextInputType.name,
                  cursorColor: azul_logo,
                  decoration: InputDecoration(
                    //icon: Icon(Icons.search, color: azul_logo),
                    border: InputBorder.none,
                    hintText: "Título ...",
                  ),
                  onChanged: (newValue) {
                    titulo = newValue;
                    setState(() {});
                  },
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
                  onChanged: (newValue) {
                    desc = newValue;
                    setState(() {});
                  },
                ).paddingLeft(10),
              )
                  .cornerRadiusWithClipRRect(12)
                  .paddingOnly(top: 30, left: 30, right: 30),
              10.height,
              SmartSelect<String>.single(
                tileBuilder: (context, state) {
                  return S2Tile(
                    title: state.titleWidget,
                    leading: Icon(Icons.bar_chart_rounded),
                    value: state.valueDisplay,
                    onTap: state.showModal,
                    isLoading: false,
                  );
                },
                modalConfig: S2ModalConfig(
                  type: S2ModalType.popupDialog,
                  style: S2ModalStyle(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                modalHeaderStyle: S2ModalHeaderStyle(
                    backgroundColor: azul_logo,
                    textStyle: TextStyle(color: white)),
                title: 'Dificultad',
                value: value1,
                choiceItems: options,
                onChange: (state) => setState(() => value1 = state.value),
              ),
              SmartSelect<String>.single(
                tileBuilder: (context, state) {
                  return S2Tile(
                    title: state.titleWidget,
                    leading: Icon(Icons.grid_view),
                    value: state.valueDisplay,
                    onTap: state.showModal,
                    isLoading: false,
                  );
                },
                modalConfig: S2ModalConfig(
                  type: S2ModalType.fullPage,
                ),
                modalHeaderStyle: S2ModalHeaderStyle(
                  backgroundColor: azul_logo,
                  textStyle: TextStyle(color: white),
                  iconTheme: IconThemeData(color: white),
                ),
                title: 'Categoria',
                value: value2,
                choiceItems: categorias,
                onChange: (state) => setState(() => value2 = state.value),
              ),
              SmartSelect<String>.single(
                tileBuilder: (context, state) {
                  return S2Tile(
                    title: state.titleWidget,
                    leading: Icon(Icons.av_timer),
                    value: state.valueDisplay,
                    onTap: state.showModal,
                    isLoading: false,
                  );
                },
                modalConfig: S2ModalConfig(
                  type: S2ModalType.popupDialog,
                  style: S2ModalStyle(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                modalHeaderStyle: S2ModalHeaderStyle(
                    backgroundColor: azul_logo,
                    textStyle: TextStyle(color: white)),
                title: 'Duración',
                value: value4,
                choiceItems: tiempos,
                onChange: (state) => setState(() => value4 = state.value),
              ),
              SmartSelect<String>.single(
                tileBuilder: (context, state) {
                  return S2Tile(
                    title: state.titleWidget,
                    leading: Icon(Icons.brush_rounded),
                    value: state.valueDisplay,
                    hideValue: true,
                    onTap: () async {
                      result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Materiales()));
                      setState(() {});
                    },
                    isLoading: false,
                  );
                },
                modalConfig: S2ModalConfig(
                  type: S2ModalType.popupDialog,
                  style: S2ModalStyle(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                modalHeaderStyle: S2ModalHeaderStyle(
                    backgroundColor: azul_logo,
                    textStyle: TextStyle(color: white)),
                title: 'Materiales',
                value: value4,
                choiceItems: tiempos,
                onChange: (state) => setState(() => value4 = state.value),
              ),
              20.height,
              ElevatedButton(
                onPressed: () {
                  if (titulo != "" &&
                      desc != "" &&
                      value1 != "" &&
                      value2 != "" &&
                      value4 != "" &&
                      result != "" &&
                      foto != null) {
                    map['titulo'] = titulo;
                    map['subtitulo'] = desc;
                    map['rutaFoto'] = foto;
                    map['dificultad'] = value1;
                    map['materiales'] = result;
                    map['categoria'] = value2;
                    map['duracion'] = value4;
                    map['descripcion'] = desc;
                    print(map);
                    print(result);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubirPasos(map),
                      ),
                    );
                  } else {
                    toast("Rellena todos los parámetros", bgColor: toast_color);
                  }
                },
                child: Text(
                  'Continuar',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(120, 50),
                  //primary: Colors.lightBlueAccent[200],
                  primary: Color.fromRGBO(68, 102, 216, 1.0),
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                  ),
                ),
              ).paddingOnly(bottom: 10),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

var current = 1;

String value1 = 'flutter';
List<S2Choice<String>> options = [
  S2Choice<String>(value: '1', title: 'Fácil'),
  S2Choice<String>(value: '2', title: 'Intermedio'),
  S2Choice<String>(value: '3', title: 'Difícil'),
];

String value2 = 'Indeterminada';

List<S2Choice<String>> categorias = [
  /*
  S2Choice<String>(value: 'Reciclable', title: 'Reciclable'),
  S2Choice<String>(value: 'Papel', title: 'Papel'),
  S2Choice<String>(value: 'Porcelana', title: 'Porcelana'),
  S2Choice<String>(value: 'Joyas', title: 'Joyas'),
  S2Choice<String>(value: 'Jabones', title: 'Jabones'),
  S2Choice<String>(value: 'Lana', title: 'Lana'),
  S2Choice<String>(value: 'Madera', title: 'Madera'),
  S2Choice<String>(value: 'Foam', title: 'Foam'),*/
];

List<int> value3 = [2];
List<S2Choice<int>> frameworks = [
  S2Choice<int>(value: 1, title: 'Papel'),
  S2Choice<int>(value: 2, title: 'Piedra'),
  S2Choice<int>(value: 3, title: 'Tijeras'),
];

String value4 = 'indef';
List<S2Choice<String>> tiempos = [
  S2Choice<String>(value: '<10', title: '<10 min.'),
  S2Choice<String>(value: '10', title: '10 min.'),
  S2Choice<String>(value: '20', title: '20 min.'),
  S2Choice<String>(value: '30', title: '30 min.'),
  S2Choice<String>(value: '40', title: '40 min.'),
  S2Choice<String>(value: '50', title: '50 min.'),
  S2Choice<String>(value: '60', title: '60 min.'),
  S2Choice<String>(value: '>60', title: '>60 min.'),
];
