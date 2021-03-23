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
