import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';
import 'package:socialcraft/utils/fonts.dart';
import 'package:socialcraft/resp.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool showPassword = false;
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  String user = "";
  String pass = "";
  var resp;

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

  Future loginUser(String user, String pass) async {
    final response = await http.post(
      Uri.https('api.socialcraft.club', 'login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'user': user, 'pass': pass}),
    );
    //print('Response body: ${response.body}');
    //print(response.body);
    return (response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(socialcraft_logo,
                            width: 100, height: 100),
                      ).cornerRadiusWithClipRRect(16).paddingTop(50),
                      Container(
                        child: Image.asset(socialcraft_logo_letras,
                            width: 300, height: 100),
                      ).cornerRadiusWithClipRRect(16).paddingTop(1),
                      //Text("SocialCraft", style: boldTextStyle(size: 32)),
                    ],
                  ),
                ),
                Container(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Container(
                          //decoration: BoxDecoration(color: appStore.isDarkModeOn ? appStore.cardColor : Colors.grey[100]),
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: TextFormField(
                            focusNode: emailNode,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            style: secondaryTextStyle(),
                            onFieldSubmitted: (term) {
                              emailNode.unfocus();
                              FocusScope.of(context).requestFocus(passwordNode);
                            },
                            onSaved: (newValue) {
                              user = newValue;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nombre de usuario o Email",
                              hintStyle: secondaryTextStyle(size: 16),
                            ),
                          ).paddingOnly(left: 8, top: 2),
                        ).cornerRadiusWithClipRRect(12),
                        Container(
                          //decoration: BoxDecoration(color: appStore.isDarkModeOn ? appStore.cardColor : Colors.grey[100]),
                          decoration: BoxDecoration(color: Colors.grey[100]),
                          child: TextFormField(
                            focusNode: passwordNode,
                            autofocus: false,
                            obscureText: showPassword ? false : true,
                            keyboardType: TextInputType.emailAddress,
                            style: secondaryTextStyle(),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  showPassword = !showPassword;
                                  setState(() {});
                                },
                                child: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              hintText: "Contraseña",
                              hintStyle: secondaryTextStyle(size: 16),
                            ),
                          ).paddingOnly(left: 8, top: 2),
                        )
                            .cornerRadiusWithClipRRect(12)
                            .paddingOnly(top: 16, bottom: 16),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("¿Has olvidado la contraseña?",
                              style: boldTextStyle(color: azul_logo)),
                        ).onTap(() {
                          Navigator.pushNamed(context, "forgotPassword");
                        }),
                      ],
                    ),
                  ),
                ).paddingTop(32),
                Container(
                  child: Column(
                    children: [
                      CommonButton("Iniciar sesión")
                          .paddingOnly(top: 16, bottom: 16)
                          .onTap(() {
                        //loginUser('arnau', '1234');
                        loginUser('Arnau', '1234').then((data) {
                          print(data);
                        });

                        finish(context);
                        Navigator.pushNamed(context, "perfil");
                      }),
                      Container(
                        width: context.width(),
                        //color: appStore.cardColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(google_logo, width: 25, height: 25),
                            Text("Conectar con google",
                                    style: TextStyle(
                                        color: Color(0xFF757575), fontSize: 16))
                                .paddingAll(16),
                          ],
                        ),
                      ).cornerRadiusWithClipRRect(12),
                    ],
                  ),
                ).paddingTop(32),
                Container(
                  child: createRichText([
                    TextSpan(
                        text: "¿No estas registrado?",
                        style: TextStyle(color: Color(0xFF757575))),
                    TextSpan(
                        text: "  Crear cuenta",
                        style: boldTextStyle(color: azul_logo)),
                  ]).onTap(() {
                    Navigator.pushNamed(context, "register");
                    setState(() {});
                  }),
                ).paddingOnly(top: 32, bottom: 32)
              ],
            ),
          ),
        ).paddingOnly(top: 16, left: 16, right: 16),
      ),
    );
  }
}
