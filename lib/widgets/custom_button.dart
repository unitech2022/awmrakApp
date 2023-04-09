
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String text, fontFamily;
  final void Function() onPress;
  final Color color, textColor;
  final double height;
  final double fontSize;
  double width;
  double redius;
bool isBorder;
bool isCustomColor;
  CustomButton(
      {Key? key, this.width=double.infinity,

        required this.text,
        required this.fontFamily,
        required this.onPress,
        required this.color,
        required this.textColor,
        required this.fontSize,
      required this.height,
        this.isBorder=true,
      this.redius=50,
      this.isCustomColor=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        elevation: 5,
        color:!isCustomColor?Theme.of(context).textTheme.headline6!.color:color,
        padding: const EdgeInsets.symmetric(vertical: 3),
        onPressed: onPress,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(redius),
            side:isBorder  ? BorderSide(color: color,width: 1.5): BorderSide(color: color,width: 0)),
        child: Center(
          child:
          Text(
            text,
            style: TextStyle(

              fontFamily: fontFamily,
              fontSize: fontSize,
              color:Colors.white,
              height: 1.2,
              fontWeight:FontWeight.bold,
            ),

          ),
        ),
      ),
    );
  }
}








// ignore: must_be_immutable
class CustomButton3 extends StatelessWidget {
  final String text, fontFamily;
  final void Function() onPress;
  final Color color, textColor;
  final double height;
  final double fontSize;
  double width;
  double redius;
  bool isBorder;
  bool isCustomColor;
  CustomButton3(
      {Key? key, this.width=double.infinity,

        required this.text,
        required this.fontFamily,
        required this.onPress,
        required this.color,
        required this.textColor,
        required this.fontSize,
        required this.height,
        this.isBorder=true,
        this.redius=50,
        this.isCustomColor=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        elevation: 5,
color: color,
        padding: const EdgeInsets.symmetric(vertical: 3),
        onPressed: onPress,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(redius),
            side: BorderSide(color: color,width: 1)),
        child: Center(
          child:
          Text(
            text,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: fontSize,
              
              color:textColor,
              height: 1.2,
              fontWeight:FontWeight.bold,
            ),

          ),
        ),
      ),
    );
  }
}