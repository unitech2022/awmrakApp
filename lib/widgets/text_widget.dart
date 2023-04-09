import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text, fontFamliy;
  final double fontSize;
  final Color color;
  final double width;
   var alignt;

  TextWidget(
      {Key? key, required this.width,
      required this.text,
      required this.fontFamliy,
      required this.fontSize,
      required this.color,this.alignt=TextAlign.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamliy,
        fontSize: fontSize,
        color: color,
        height: 1.2,
        fontWeight: FontWeight.bold,
      ),
      textAlign: alignt,
    );
  }
}

class TextWidget2 extends StatelessWidget {
  final String text, fontFamliy;
  final double fontSize;
  final Color color;
  final double width;
  var alginText;
  var lines;
  bool isCustomColor;

  TextWidget2(
      {this.lines = null,
        this.isCustomColor=false,
      this.alginText = TextAlign.center,
      required this.width,
      required this.text,
      required this.fontFamliy,
      required this.fontSize,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Text(
        text,

        maxLines: lines,
        style: TextStyle(
          fontFamily: fontFamliy,
          fontSize: fontSize,
          color:isCustomColor?color: Theme.of(context).textTheme.bodyText1!.color,
          height: 1.2,

          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: alginText,
      ),
    );
  }
}

class TextWidget3 extends StatelessWidget {
  final String text, fontFamliy;
  final double fontSize;
  final Color color;

  var alginText;
  var lines;
bool isCustomColor;

  TextWidget3(
      {this.lines = null,this.isCustomColor=false,
      this.alginText = TextAlign.center,
      required this.text,
      required this.fontFamliy,
      required this.fontSize,

      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      style: TextStyle(
        fontFamily: fontFamliy,
        fontSize: fontSize,
        color:isCustomColor?color: Theme.of(context).textTheme.bodyText1!.color,
        height: 1.4,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: alginText,
    );
  }
}
