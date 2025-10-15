import 'package:flutter/material.dart';
import 'package:quran_application/screens/surahscreen.dart';
import 'package:quran_application/screens/splashscreen.dart';


void main() {
  runApp(
    Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Splashscreen()),
    ),
  );
}
