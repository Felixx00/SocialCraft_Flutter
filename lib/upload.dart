import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:smart_select/smart_select.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

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
              SmartSelect<int>.multiple(
                  modalConfig: S2ModalConfig(
                    type: S2ModalType.fullPage,
                  ),
                  //choiceLayout: S2ChoiceLayout.list,
                  modalHeaderStyle: S2ModalHeaderStyle(
                      backgroundColor: azul_logo,
                      textStyle: TextStyle(color: white)),
                  title: 'Materiales',
                  value: value3,
                  choiceItems: frameworks,
                  onChange: (state) => setState(() => value3 = state.value),
                  tileBuilder: (context, state) {
                    return S2Tile.fromState(
                      state,
                      trailing: const Icon(Icons.arrow_drop_down),
                      isTwoLine: true,
                    );
                  }),
              TextButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Text('Tiempooo'))
            ],
          ),
        ),
      ),
    );
  }
}

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

showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: Text("Sí"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget picker = TimePickerSpinner(
    is24HourMode: true,
    normalTextStyle: TextStyle(fontSize: 24, color: azul_logo),
    highlightedTextStyle: TextStyle(fontSize: 24, color: azul_logo),
    spacing: 50,
    itemHeight: 80,
    isForce2Digits: true,
  );

  AlertDialog alert = AlertDialog(
    content: picker,
    actions: [cancelButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
