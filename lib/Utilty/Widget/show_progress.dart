import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:flutter/material.dart';

class ShowProgress extends StatelessWidget {
  const ShowProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MyStyle.primary,
      ),
    );
  }
}
