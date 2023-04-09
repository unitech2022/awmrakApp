import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// class CustomDropDownWidget2 extends StatefulWidget {
//   final  List<String> list;
//   final Function onSelect;
//   final double height;
//   final String hint;
//
//    CustomDropDownWidget2({required this.height,required this.list, required this.onSelect,required this.hint});
//
//   @override
//   _CustomDroopDownWidgetState createState() => _CustomDroopDownWidgetState();
// }
//
// class _CustomDroopDownWidgetState extends State<CustomDropDownWidget2> {
//   String? currentValue;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
// mainAxisSize: MainAxisSize.min,
//       children: [
//
//
//         DropdownButton<String>(
//
//             hint: Text(widget.hint,
//                 textAlign: TextAlign.right,
//                 style: const TextStyle(
//                   fontFamily: 'pnuB',
//                   fontSize: 10,
//                   color: Color(0x99000000),
//                   height: 2.2,
//                 )),
//             style: const TextStyle(
//               fontFamily: 'pnuB',
//               fontSize: 10,
//               color: Color(0x99000000),
//               height: 2.2,
//             ),
//             value: currentValue,
//             icon: const SizedBox(),
//             iconSize: 25,
//             underline: const SizedBox(),
//             onChanged: (value) {
//               setState(() {
//                 currentValue = value;
//               });
//
//               widget.onSelect(value!);
//             },
//             items:
//             widget.list.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Container(
//                   color: Colors.white,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         value,
//                         textAlign: TextAlign.right,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList()),
//         const Icon(
//           Icons.keyboard_arrow_down_sharp,
//           color: Colors.black,
//         ),
//       ],
//     );
//   }
//
//
// }