import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_application/helper/links.dart';
  import 'package:quran_application/helper/network_helper.dart';
import 'package:quran_application/screens/listsurahscreen.dart';
import 'package:quran_application/utils/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
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
    return Scaffold(
       body: Center(
        child:  CircularProgressIndicator(color: primaryColor,),
      ),
    );
  }
}
