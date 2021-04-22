import 'package:flutter/material.dart';
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

class EditPost extends StatefulWidget {
  static String tag = '/upload';

  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
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

  List<String> result = ['Tiempooo', 'a', 'b'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Editar'),
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
              20.height,
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
              10.height,
              SmartSelect<String>.single(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    child: TextButton(
                      onPressed: () async {
                        result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Materiales()));
                        setState(() {});
                      },
                      child: Text('Materiales'),
                    ),
                  ),
                  Card(
                    child: TextButton(
                      onPressed: () async {
                        NumberPicker(
                          value: current,
                          minValue: 0,
                          maxValue: 100,
                          onChanged: (value) => setState(() => current = value),
                        );
                      },
                      child: Text('Duración'),
                    ),
                  )
                ],
              ),
              25.height,
              ElevatedButton(
                onPressed: () {
                  print(result);
                },
                child: Text(
                  'Submit',
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
              )
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
