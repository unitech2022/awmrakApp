import 'package:flutter/cupertino.dart';

class DviderHorizental extends StatelessWidget {
  final Color color;

  DviderHorizental(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: double.infinity,
      width: 8,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(25)),
    );
  }
}