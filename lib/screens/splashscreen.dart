import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quran_application/screens/homescreen.dart';
import 'package:quran_application/utils/constants.dart'; 

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  
 @override
  void initState() {
     super.initState();
      Future.delayed(Duration(seconds: 10),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homescreen()));
      });
   }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image(
              image: AssetImage('assets/logo.png'),
              height: 200,
              width: 200,
            ),
            Text(" رحلتك اليومية مع القرآن والذكر ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20), )
          ],
        ),
      ),
    );
  }
}
