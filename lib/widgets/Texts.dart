import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  final color;
  final weight;
  final int fSize;
  final lines;
  final align;
  final title;
  final familay;
  Texts({this.familay,this.title,this.color=Colors.black, this.weight=FontWeight.normal, required this.fSize,this.lines=1,this.align=TextAlign.start});
  @override
  Widget build(BuildContext context) {
    return  Text(title,style: TextStyle(fontFamily:familay,color: color,fontWeight: weight,fontSize: fSize.toDouble(),),maxLines: lines,textAlign: align);
  }
}
