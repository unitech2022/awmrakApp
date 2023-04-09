import 'package:awarake/helpers/data/data.dart';
import 'package:awarake/helpers/styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  final List<Governorate> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool isTwoIcons;

  final Color iconColor, textColor;
  final dynamic currentValue;
  final bool selectCar;

  const CustomDropDownWidget(
      {this.selectCar = false,
      required this.currentValue,
      required this.textColor,
      required this.iconColor,
      this.isTwoIcons = false,
      required this.list,
      required this.onSelect,
      required this.hint});

  @override
  _CustomDroopDownWidgetState createState() => _CustomDroopDownWidgetState();
}

class _CustomDroopDownWidgetState extends State<CustomDropDownWidget> {
  String? currentValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        items: widget.list
            .map((item) => DropdownMenuItem<dynamic>(
                value: item,
                child: Text(

                  item.governorateNameAr!,
                  style: const TextStyle(
                    fontFamily: "pnuR",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                )))
            .toList(),
        value: widget.currentValue,
        onChanged: widget.onSelect,
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: Colors.white,
        ),
        iconSize: 18,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,
        buttonDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 500,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),

        hint: Text(
          widget.hint,
          style: const TextStyle(fontFamily: "pnuR", fontSize: 13),
        ),
      ),
    );
  }
}




class CustomDropDownCity extends StatefulWidget {
  final List<CityModel> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool isTwoIcons;

  final Color iconColor, textColor;
  final dynamic currentValue;
  final bool selectCar;

  const CustomDropDownCity(
      {this.selectCar = false,
        required this.currentValue,
        required this.textColor,
        required this.iconColor,
        this.isTwoIcons = false,
        required this.list,
        required this.onSelect,
        required this.hint});

  @override
  _CustomDropDownCityState createState() => _CustomDropDownCityState();
}

class _CustomDropDownCityState extends State<CustomDropDownCity> {
  String? currentValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        items: widget.list
            .map((item) => DropdownMenuItem<dynamic>(
            value: item,
            child: Text(
              item.cityNameAr!,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: "pnuR",
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            )))
            .toList(),
        value: widget.currentValue,
        onChanged: widget.onSelect,
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: Colors.white,
        ),
        iconSize: 18,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,
        buttonDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 500,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
        hint: Text(
          widget.hint,
          style: const TextStyle(fontFamily: "pnuR", fontSize: 13),
        ),
      ),
    );
  }
}



class CustomDropDownWidget2 extends StatefulWidget {
  final List<dynamic> list;
  final Function(dynamic) onSelect;
  final String hint;
  final List<DropdownMenuItem<dynamic>> listWidget;
  final bool isTwoIcons;

  final Color iconColor, textColor;
  var backroundColor,hintColor;
  final dynamic currentValue;
  final bool selectCar;

  CustomDropDownWidget2(
      {this.selectCar = false,
        this.backroundColor=Colors.white,
        required this.currentValue,
        required this.textColor,
        required this.iconColor,

        this.hintColor=Colors.black,
        required this.listWidget,
        this.isTwoIcons = false,
        required this.list,
        required this.onSelect,
        required this.hint});

  @override
  _CustomDroopDownWidget2State createState() => _CustomDroopDownWidget2State();
}

class _CustomDroopDownWidget2State extends State<CustomDropDownWidget2> {
  String? currentValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        items:widget.listWidget,
        value: widget.currentValue,
        onChanged: widget.onSelect,
        icon:  Icon(
          Icons.keyboard_arrow_down_sharp,
          color: widget.textColor,
        ),
        iconSize: 18,

        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,
        buttonDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 500,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: widget.backroundColor,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),

        hint: Text(
          widget.hint,
          style:  TextStyle(fontFamily: "pnuB", fontSize: 13,color: widget.hintColor),
        ),
      ),
    );
  }
}
