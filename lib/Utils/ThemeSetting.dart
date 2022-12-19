// @dart=2.9
import 'package:flutter/material.dart';

darkTheme(context) {
  return ThemeData.dark();
}

lightTheme(context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    accentColor: Colors.blue,
  );
}
