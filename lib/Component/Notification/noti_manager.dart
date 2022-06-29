import 'package:flutter/material.dart';

class NotiManager extends StatefulWidget {
  const NotiManager({Key? key}) : super(key: key);

  @override
  _NotiManagerState createState() => _NotiManagerState();
}

class _NotiManagerState extends State<NotiManager> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(),
    );
  }
}
