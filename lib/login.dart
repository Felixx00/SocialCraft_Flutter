import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/images.dart';

void main() => runApp(Login());

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
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(color: Colors.blue),
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
                              hintText: "Email or Phone number",
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
                              hintText: "Password",
                              hintStyle: secondaryTextStyle(size: 16),
                            ),
                          ).paddingOnly(left: 8, top: 2),
                        )
                            .cornerRadiusWithClipRRect(12)
                            .paddingOnly(top: 16, bottom: 16),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",
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
                      CommonButton("Sign In")
                          .paddingOnly(top: 16, bottom: 16)
                          .onTap(() {
                        finish(context);
                        //HMDashBoard().launch(context);
                      }),
                      Container(
                        width: context.width(),
                        //color: appStore.cardColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(google_login, width: 25, height: 25),
                            Text("Connect with google",
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
                        text: "You don't have an account?",
                        style: TextStyle(color: Color(0xFF757575))),
                    TextSpan(
                        text: "Sign Up",
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
