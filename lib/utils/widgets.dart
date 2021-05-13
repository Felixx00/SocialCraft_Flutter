import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/post2.dart';
import 'package:socialcraft/utils/fonts.dart';

class CommonButton extends StatelessWidget {
  final String buttonName;

  CommonButton(
    this.buttonName,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: azul_logo),
      width: context.width(),
      child: Text(buttonName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          )).center().paddingOnly(top: 16, bottom: 16),
    ).cornerRadiusWithClipRRect(12);
  }
}

Widget targetaTutorial(
    context, linkFoto, titulo, usuario, rate, descripcion, post) {
  bool correct = false;
  if (rate != "0") correct = true;
  return Card(
    margin: EdgeInsets.all(16),
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Post2(post).launch(context);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: Image.network(linkFoto,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(titulo,
                        style: boldTextStyle(size: 20, color: textPrimaryColor))
                    .paddingOnly(left: 16),
                Text("@" + usuario,
                        style: TextStyle(fontSize: 16, color: azul_logo))
                    .paddingOnly(left: 16, right: 16, top: 5),
                Text(
                  correct ? rate + "/5" : "-",
                  style: TextStyle(fontSize: 20, color: textPrimaryColor),
                  textAlign: TextAlign.right,
                ).paddingOnly(right: 1),
                Icon(Icons.star_outlined, color: azul_logo, size: 22),
              ],
            ),
            /*
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(titulo,
                  style: boldTextStyle(size: 20, color: textPrimaryColor)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(usuario,
                  style: TextStyle(fontSize: 16, color: azul_logo)),
            ), */
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(descripcion,
                  style: secondaryTextStyle(size: 16, color: textPrimaryColor)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
