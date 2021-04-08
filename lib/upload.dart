import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';
import 'package:socialcraft/utils/fonts.dart';

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
        body: SingleChildScrollView(),
      ),
    );
  }
}
