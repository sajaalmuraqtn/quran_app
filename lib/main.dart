import 'package:flutter/material.dart';
import 'package:quran_application/screens/homescreen.dart';
import 'package:quran_application/screens/prayerTimesScreen.dart';
import 'package:quran_application/screens/surahscreen.dart';
import 'package:quran_application/screens/splashscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Splashscreen()),
    ),
  );
}
