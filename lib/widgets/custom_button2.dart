import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_text.dart';

// ignore: must_be_immutable
class CustomButton2 extends StatelessWidget {
  final void Function() onPress;
  final String icon;
  final Color color;
  double width ,height;

  CustomButton2(
      {Key? key, required this.onPress, required this.icon, required this.color,this.width=46
      ,this.height=46}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: 15,
            height: 15,
          ),
        ),
      ),
    );
  }
}


class CustomButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? iconAsset;
  final Color color,textColor;
  final bool isIcon;
  final void Function() onPress;


  const  CustomButtonWithIcon({required this.textColor,this.iconAsset,  required this.isIcon,required this.icon, required this.text, required this.color, required this.onPress,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      onPressed: onPress,
      color: color,
      height: 44,
      minWidth: double.infinity,
      child: Center(
        child: Row(

          children:  [
            Row(
              children: [
                isIcon? Icon(

                  icon,color: Colors.white,size: 18,
                ):SvgPicture.asset(
                  iconAsset!,
                  width: 25,
                  height: 25,
                )
              ],
            ),
            const Spacer(),
            CustomText(
                family: "pnuB",
                size: 12,
                text: text,
                textColor: textColor,
                weight: FontWeight.bold,
                align: TextAlign.center),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}