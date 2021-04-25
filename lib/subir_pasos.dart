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
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;

class SubirPasos extends StatefulWidget {
  static String tag = '/upload';
  var map = Map<String, dynamic>();
  SubirPasos(this.map);
  @override
  SubirPasosState createState() => SubirPasosState();
}

class SubirPasosState extends State<SubirPasos> {
  @override
  void initState() {
    super.initState();
    init();
  }

  var map2 = Map<String, dynamic>();
  String token = "";

  init() async {
    map2 = widget.map;
    final storage2 = new FlutterSecureStorage();
    token = await storage2.read(key: 'jwt');
    print(map2);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  int activeStep = 0; // Initial step set to 5.

  int upperBound = 6;
  List<int> numb = [1];
  List<String> textos = ["", "", "", "", "", "", "", "", "", ""];

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
      return Resp.fromJson3(jsonDecode(response.body));
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
        title: const Text('Editar Perfil'),
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
              onPressed: () {
                subirTuto().then((respuesta) async {
                  if (respuesta.success == false) {
                    setState(() {});
                    toast("Incorrecto bro", bgColor: toast_color);
                  } else {
                    /*
                    final storage = new FlutterSecureStorage();
                    await storage.write(
                        key: 'jwt', value: respuesta.data['token']);
                    print(respuesta.data['token']);
                    finish(context);
                    Navigator.pushNamed(context, "barra");
                    */
                    print(respuesta.success);
                  }
                });
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
                  });
                },
              ),
              header(),
              Text((activeStep + 1).toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (numb.length < 10) {
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
      ),
    ));
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    /* return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );*/
    return Container(
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: TextFormField(
        keyboardType: TextInputType.name,
        cursorColor: azul_logo,
        decoration: InputDecoration(
          //icon: Icon(Icons.search, color: azul_logo),
          border: InputBorder.none,
          hintText: 'Step ' + (activeStep + 1).toString(),
        ),
      ).paddingLeft(10),
    ).cornerRadiusWithClipRRect(12).paddingOnly(top: 30, left: 30, right: 30);
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
