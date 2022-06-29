import 'package:charoz/Model/address_model.dart';
import 'package:flutter/material.dart';

class EditLocation extends StatefulWidget {
  final AddressModel address;
  const EditLocation({Key? key, required this.address}) : super(key: key);

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
