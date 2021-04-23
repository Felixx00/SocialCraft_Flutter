import 'dart:convert';

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
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;

import 'resp.dart';

class EditPost extends StatefulWidget {
  static String tag = '/upload';
  final String idPost;
  EditPost(this.idPost);
  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
  @override
  void initState() {
    super.initState();
    init();
  }

  String token = '';
  String tutId = '';

  init() async {
    final storage = new FlutterSecureStorage();
    token = await storage.read(key: 'jwt');
    tutId = widget.idPost;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  List<String> result = ['Tiempooo', 'a', 'b'];
  bool correct = true;

  String titulo = '';
  String subtitulo = '';
  String rutaFoto = '';
  String video = '';
  String dificultad = '';
  String materiales = '';
  String duracion = '';
  String descripcion = '';
  String categoria = '';

  Future<Resp> cambios() async {
    var map = new Map<String, dynamic>();
    map['tutId'] = tutId;
    if (titulo != '') {
      map['titulo'] = titulo;
    }
    if (descripcion != '') {
      map['descripcion'] = descripcion;
    }
    if (rutaFoto != '') {
      map['rutaFoto'] = rutaFoto;
    }
    if (video != '') {
      map['video'] = video;
    }
    if (dificultad != '') {
      map['dificultad'] = dificultad;
    }
    if (materiales != '') {
      map['materiales'] = materiales;
    }
    if (duracion != '') {
      map['duracion'] = duracion;
    }
    if (categoria != '') {
      map['categoria'] = categoria;
    }
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/tutorials/editTutorial'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Resp.modificar(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Editar post'),
          backgroundColor: azul_logo,
          leading: Icon(Icons.arrow_back).onTap(() {
            Navigator.pop(context);
            //finish(context);
            //Navigator
          }),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              30.height,
              Stack(
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    padding: EdgeInsets.all(6),
                    dashPattern: [8, 8],
                    strokeWidth: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: azul_logo,
                          size: 75.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ).paddingAll(20),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    right: -30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: azul_logo),
                      child: Container(
                        alignment: AlignmentDirectional.bottomEnd,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Icon(
                          correct ? Icons.check : Icons.close,
                          color: correct ? Colors.green : Colors.red,
                          size: 24.0,
                          semanticLabel: 'A',
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
                clipBehavior: Clip.none,
              ),
              5.height,
              Container(
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  cursorColor: azul_logo,
                  onChanged: (newValue) {
                    titulo = newValue;
                  },
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
                  onChanged: (newValue) {
                    descripcion = newValue;
                  },
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
                    textStyle: TextStyle(color: white)),
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
                  cambios().then((respuesta) {
                    if (respuesta.success == false) {
                      print("Algun Parametro Incorrecto");
                    } else {
                      finish(context);
                      Navigator.pushNamed(context, 'post');
                    }
                  });
                },
                child: Text(
                  'Editar',
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
    );
  }
}

var current = 1;

String value1 = 'flutter';
List<S2Choice<String>> options = [
  S2Choice<String>(value: 'a', title: 'Fácil'),
  S2Choice<String>(value: 'b', title: 'Intermedio'),
  S2Choice<String>(value: 'c', title: 'Difícil'),
];

String value2 = '0';
List<S2Choice<String>> categorias = [
  S2Choice<String>(value: 'a', title: 'Origami'),
  S2Choice<String>(value: 'b', title: 'Lifehack'),
  S2Choice<String>(value: 'c', title: 'Téxtil'),
  S2Choice<String>(value: 'd', title: 'Jardineria'),
  S2Choice<String>(value: 'e', title: 'Bricolaje'),
  S2Choice<String>(value: 'f', title: 'Electrónica'),
  S2Choice<String>(value: 'g', title: 'Pintura'),
];

List<int> value3 = [2];
List<S2Choice<int>> frameworks = [
  S2Choice<int>(value: 1, title: 'Papel'),
  S2Choice<int>(value: 2, title: 'Piedra'),
  S2Choice<int>(value: 3, title: 'Tijeras'),
];

String value4 = 'flutter';
List<S2Choice<String>> tiempos = [
  S2Choice<String>(value: 'a', title: '<10 min.'),
  S2Choice<String>(value: 'b', title: '10 min.'),
  S2Choice<String>(value: 'c', title: '20 min.'),
  S2Choice<String>(value: 'd', title: '30 min.'),
  S2Choice<String>(value: 'e', title: '40 min.'),
  S2Choice<String>(value: 'f', title: '50 min.'),
  S2Choice<String>(value: 'g', title: '60 min.'),
  S2Choice<String>(value: 'h', title: '>60 min.'),
];
