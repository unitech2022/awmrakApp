import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Buttons extends StatelessWidget {
  final title;
  final double width;
  final int fSize;
  final textColol;
  final bool shadow;
  final bool isBold;
  final bgColor;
  final double height;

  final int radius;
  final int horizontalMargin;
  Function onPressed;
  Buttons({this.title,this.isBold = false,this.height=50,this.fSize =15,this.radius=50, required this.onPressed,this.horizontalMargin=0,required this.width,this.bgColor =const Color(0xFF1cacc1),this.textColol=Colors.white,this.shadow=true});
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin.toDouble()),
        width: width!=null?width.toDouble():double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius.toDouble()),
          boxShadow:shadow? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]:[],
        ),
        child: Center(
            child: Text(
             title,
              style: TextStyle(
                  fontSize: fSize.toDouble(),
                  color: textColol,
                   fontWeight: isBold?FontWeight.bold:FontWeight.w500
                  ),
            )),
      ),
    );

  }
}
class DefaultButton extends StatelessWidget {
  final double height;
  final String text;
  final Function onPress;
  final Color color;
  final Color colorText;

  DefaultButton(
      {required this.height,
        required this.text,
        required this.onPress,
        required this.color,
        required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () => onPress(),
        color: color,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'pnuB',
            fontSize: 17,
            color: colorText ,
            letterSpacing: 0.8500000000000001,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}