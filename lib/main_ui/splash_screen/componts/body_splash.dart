import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/router.dart';
import '../../../helpers/styles.dart';

class BodySplash extends StatefulWidget {
  @override
  _BodySplashState createState() => _BodySplashState();
}

class _BodySplashState extends State<BodySplash>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;

  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    await readToken();
    isRegistered()
        ? Navigator.of(context).pushReplacementNamed(nav)
        : Navigator.of(context).pushReplacementNamed(login);
  }

  var startAnimation = false;

  initialTimer() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      startAnimation = true;
    });
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // context.read<AddsProviders>().getSubCategoreisAdds();
      FirebaseMessaging.instance.getToken().then((value) {
        tokenFCM = value!;
        print("tokkkkkkkkkken:$tokenFCM");
      });
      // Add Your Code here.
    });

    initialTimer();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 6,
          color: KYellowColor,
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 90);
    var controllPoint = Offset(70, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

@override
bool shouldReclip(CustomClipper oldClipper) {
  return false;
}
