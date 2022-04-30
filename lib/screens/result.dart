import 'package:charoz/utils/constant/my_style.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final String result;
  const Result({Key? key, required this.result}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: Text(
            widget.result,
            style: MyStyle().boldBlue20(),
          ),
        ),
      ),
    );
  }
}
