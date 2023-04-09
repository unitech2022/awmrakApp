import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final Color textColor;
  final double size;
  final String family;
  final TextAlign align;

  

  const CustomText(
      {Key? key,
      required this.family,
      required this.size,
      required this.text,
      required this.textColor,
      required this.weight,
      required this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: family,
        fontSize: size,
        color: textColor,
        height: 1.2
      ),
      textAlign: align,
    );
  }
}


class CustomTextWithLines extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final Color textColor;
  final double size;
  final String family;
  final TextAlign align;
    final int lines;
  

  const CustomTextWithLines(
      {Key? key,
      required this.family,
      required this.size,
      required this.text,
      required this.lines,
      required this.textColor,
      required this.weight,
      required this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: family,
        fontSize: size,
        color: textColor,
        height: 1.2
      ),
      textAlign: align,
      maxLines: lines,
    );
  }
}
