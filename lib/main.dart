import 'package:flutter/material.dart';
import 'package:quran_application/screens/homescreen.dart';
import 'package:quran_application/screens/loadingscreen.dart';

void main() {
  runApp(
    Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Homescreen()),
    ),
  );
}
