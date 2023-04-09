import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';

class RichTextTitle extends StatelessWidget {
final Color color;


RichTextTitle(this.color);

  @override
  Widget build(BuildContext context) {
    return Text("أوامرك",style: TextStyle(
        fontFamily: 'pnuB',
        fontSize: 23,
        color: color,
        fontWeight: FontWeight.w200));

  }
}