import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemDraw extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() press;
  final Color color;
   Color? colorIcon =Colors.green;

  ItemDraw(
      {required this.icon,
        required this.text,
        required this.press,
        required this.color,
      this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: () => Navigator.of(context).pop(),
              child:Icon(icon,color: colorIcon,)),
          const SizedBox(
            width: 30,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'pnuM',
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.w300,
              height: 2.5,
            ),
            textHeightBehavior:
            const TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.start,
          ),

        ],
      ),
    );
  }
}