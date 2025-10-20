import 'package:flutter/material.dart';

class Sabahathkar extends StatelessWidget {
  const Sabahathkar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/logo.png')),

        title: Text(
          "أذكار الصباح - القرآن الكريم",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white,size: 30,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Container( 
          child: Image(image: AssetImage('assets/sabahathkar.jpg') ) ,
         )
      ),
    );
  }
}