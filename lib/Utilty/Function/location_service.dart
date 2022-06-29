import 'dart:io';

import 'package:charoz/Utilty/Constant/my_style.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> checkPermission(BuildContext context) async {
    bool locationService;
    LocationPermission locationPermission;
    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          return false;
        } else {
          return true;
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          return false;
        } else {
          return true;
        }
      }
    } else {
      return false;
    }
  }

  Future alertLocationService(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          title: Text(
            title,
            style: MyStyle().boldPrimary14(),
          ),
          subtitle: Text(
            message,
            style: MyStyle().normalPrimary14(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Geolocator.openLocationSettings();
              exit(0);
            },
            child: Text(
              'OK',
              style: MyStyle().boldBlue14(),
            ),
          )
        ],
      ),
    );
  }
}
