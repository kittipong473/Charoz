import 'package:charoz/Util/Constant/my_style.dart';
import 'package:flutter/material.dart';

class DropDownMenu {
  DropdownMenuItem<String> dropdownItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item, style: MyStyle().normalBlack16()),
    );
  }
}
