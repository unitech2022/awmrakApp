
import 'package:flutter/material.dart';

import 'componts/body_splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Colors.white ,
      body: BodySplash(),
    );
  }
}
