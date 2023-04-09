import 'package:flutter/cupertino.dart';

class MyClipperDraw extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final pathOrange = Path();

// Create your line from the top left down to the bottom of the orange
    pathOrange.lineTo(0, size.height * .4387);

// Create your line to the bottom right of orange
    pathOrange.lineTo(size.width, size.height * .0);

// Create your line to the top right corner
    pathOrange.lineTo(size.width, .500); // 0 on the Y axis (top)

// Close your line to where you started (0,0)
    pathOrange.close();

// Draw your path
    return pathOrange;
  }



  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}