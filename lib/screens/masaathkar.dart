import 'package:flutter/material.dart';

class Masaathkar extends StatelessWidget {
  const Masaathkar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/logo.png')),

        title: Text(
          "أذكار المساء - القرآن الكريم",
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/masaathkar.jpg'),
              fit: BoxFit.cover,
            ),
          ),
         )
      ),
    );
  }
}