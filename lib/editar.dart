import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/widgets.dart';

class Editar extends StatefulWidget {
  static String tag = '/editar';

  @override
  EditarState createState() => EditarState();
}

class EditarState extends State<Editar> {
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
          title: const Text('SocialCraft'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
