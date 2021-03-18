import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';

class ForgotPassword extends StatefulWidget {
  static String tag = '/forgotPassword';

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          //appStore.cardColor,
          //iconTheme: IconThemeData(color: appStore.isDarkModeOn ? appBarBackgroundColor : scaffoldColorDark),
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
                      "Porfavor introduce tu email debajo y te \nenviaremos el código de recuperación",
                      style: TextStyle(color: Color(0xFF757575), fontSize: 16),
                      textAlign: TextAlign.center,
                    ).paddingTop(18.0),
                    Container(
                      //decoration: BoxDecoration(color: appStore.isDarkModeOn ? appStore.cardColor : Colors.grey[100]),
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: TextFormField(
                        autofocus: false,
                        style: secondaryTextStyle(),
                        keyboardType: TextInputType.emailAddress,
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
                finish(context);
                //HMEmailVerificationScreen().launch(context);
              })
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}
