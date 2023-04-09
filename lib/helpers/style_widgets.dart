import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StylesWidget {

  static var currentValueLocal;
  static BoxDecoration getDecoration(Color color) {
    return BoxDecoration(

      borderRadius: BorderRadius.circular(28.0),
      color: const Color(0xffe2e2e2),

    );
  }
  static SvgPicture getSvg(String icon,double width,double height) {
    return SvgPicture.asset(
      icon,

      width: width,
      height: height,
    );
  }

  static TextStyle getTextStyle(Color colorFont, double fontSize) {
    return TextStyle(
      fontFamily: 'home',
      fontSize: fontSize,
      color: colorFont,
      height: 2.5,
    );
  }

  static BoxDecoration getBoxDecorationCircle(Color color) {
    return BoxDecoration(
      shape: BoxShape.circle,

      color: color,
    );
  }

}

final otpInputDecoration = InputDecoration(

  contentPadding:
  const EdgeInsets.symmetric(vertical: 10),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);


OutlineInputBorder outlineInputBorder() {
  return const OutlineInputBorder(

  );
}