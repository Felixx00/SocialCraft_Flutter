import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialcraft/utils/images.dart';

class Transition extends StatefulWidget {
  @override
  TransitionState createState() => TransitionState();
}

class TransitionState extends State<Transition> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _controller = AnimationController(
        duration: const Duration(seconds: 2), vsync: this, value: 0.1);

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
    startTime();
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (mounted) {
      finish(context);
      Navigator.pushNamed(context, "login");
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: appStore.isDarkModeOn ? scaffoldColorDark : appBarBackgroundColor,
        body: Center(
          child: ScaleTransition(
              scale: _animation,
              alignment: Alignment.center,
              child: Image.asset(socialcraft_logo, height: 150, width: 150)),
        ),
      ),
    );
  }
}
