import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/resp.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  static String tag = '/forgotPassword';

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  String mail = "";
  bool correct_mail = true;

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

  Future<Resp> recoverPassword(String mail) async {
    var map = new Map<String, dynamic>();
    map['email'] = mail;
    final response = await http.post(
      Uri.https('api.socialcraft.club', '/users/recoverPassword'),
      body: map,
    );
    if (response.statusCode == 200) {
      return Resp.fromJson2(jsonDecode(response.body));
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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          leading: Icon(Icons.arrow_back).onTap(() {
            finish(context);
          }),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Text("¿Has olvidado \nla contraseña?",
                        style: boldTextStyle(size: 32)),
                    Text(
                      "Porfavor introduce tu email a continuación \ny te enviaremos el código de recuperación.",
                      style: TextStyle(color: Color(0xFF757575), fontSize: 16),
                      textAlign: TextAlign.center,
                    ).paddingTop(20.0),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: TextFormField(
                        cursorColor: azul_logo,
                        autofocus: false,
                        style: secondaryTextStyle(
                            color: correct_mail ? Colors.black : Colors.red),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (newValue) {
                          mail = newValue;
                          correct_mail = true;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: secondaryTextStyle(size: 16)),
                      ).paddingOnly(left: 8, top: 2),
                    )
                        .cornerRadiusWithClipRRect(12)
                        .paddingOnly(top: 16, bottom: 8)
                  ],
                ),
              ),
              20.height,
              CommonButton("Enviar").onTap(() {
                if (mail.validateEmail()) {
                  correct_mail = true;
                  recoverPassword(mail).then((respuesta) async {
                    if (respuesta.success == false) {
                    } else {
                      finish(context);
                      toast("Email enviado correctamente",
                          bgColor: toast_color);
                    }
                  });
                } else {
                  correct_mail = false;
                  setState(() {});
                  toast("Email incorrecto", bgColor: toast_color);
                }
              })
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
