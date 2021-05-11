import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
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

Widget targetaTutorial(context, linkFoto, titulo, usuario, descripcion) {
  return Card(
    margin: EdgeInsets.all(16),
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {},
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
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(descripcion,
                  style:
                      secondaryTextStyle(size: 16, color: textSecondaryColor)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
