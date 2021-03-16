import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';

void main() => runApp(Login());

// ignore: must_be_immutable
class Login extends StatelessWidget {
  bool showPassword = false;
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      8.height,
                      Text("SocialCraft", style: boldTextStyle(size: 32)),
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
                          child: TextFormField(
                            focusNode: emailNode,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            style: secondaryTextStyle(),
                            onFieldSubmitted: (term) {
                              emailNode.unfocus();
                              FocusScope.of(context).requestFocus(passwordNode);
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
                                  //setState(() {});
                                },
                                child: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey),
                              ),
                              border: InputBorder.none,
                              hintText: "contraseña",
                              hintStyle: secondaryTextStyle(size: 16),
                            ),
                          ).paddingOnly(left: 8, top: 2),
                        )
                            .cornerRadiusWithClipRRect(12)
                            .paddingOnly(top: 16, bottom: 16),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("¿Has olvidado la contraseña?",
                              style: boldTextStyle(color: Colors.blue)),
                        ).onTap(() {
                          //HMForgotPasswordScreen().launch(context);
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
                        finish(context);
                        Navigator.pushNamed(context, "edit");
                      }),
                      Container(
                        width: context.width(),
                        //color: appStore.cardColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(google_login, width: 25, height: 25),
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
                        text: "Crear cuenta",
                        style: boldTextStyle(color: Colors.blue)),
                  ]).onTap(() {
                    Navigator.pushNamed(context, "register");
                    //setState(() {});
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
