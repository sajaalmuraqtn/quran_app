import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_application/helper/links.dart';
  import 'package:quran_application/helper/network_helper.dart';
import 'package:quran_application/screens/listsurahscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  
  Links links =  Links();
@override
  void initState() {
     super.initState();
     links.getAllSurahs().then((allsurahs){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListSurahsScreen(surahList:allsurahs,)));
       //الانتقال الى الصفحة الرئيسية مع ارسال كل السور
     });
   }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image(
              image: AssetImage('assets/quran.gif'),
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
