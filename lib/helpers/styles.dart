
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const homeColor = Color(0xff06114E);
const secondColor = Colors.yellow;
const textColor = Color(0xff292A24);
const unSelectIconColor = Color(0xff676767);
const backgroundColor = Colors.yellow;
const priceColor = Color(0xff2CB4FA);
const KHomeColor=Color(0xFFF5833C);
const KYellowColor=Color(0xFFFFCA08);
const KGreyColor=Color(0xFFE2E2E2);
const KYellow2Color=Color(0xFFFFDD2C);
const KBrownColor=Color(0xFFF5833C);
const KBlack2Color=Color(0xFF464646);
const KBlackColor=Color(0xFF707070);
const KBluColor=Color(0xFF200E32);
const KGreenColor=Color(0xFF7CAC21);
const KYellow3Color=Color(0xFFFFD700);
const KTextColor=Color(0xFF898A8F);
const KText2Color= Color(0x6f000000);
BoxDecoration decoration({required double redias,required Color color}) => BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(redias),
    );

 paddingSymmetric({required double hor,required double ver}) =>
    EdgeInsets.symmetric(horizontal: hor, vertical: ver);

EdgeInsetsGeometry paddingOnly({required double top, required double bottom,required double  left, required double right}) =>
    EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);


