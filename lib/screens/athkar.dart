import 'package:flutter/material.dart';
import 'package:quran_application/models/masaandsabahathkar.dart';
import 'package:quran_application/screens/homescreen.dart';
import 'package:quran_application/utils/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AthkarScreen extends StatefulWidget {
  const AthkarScreen({super.key, required this.AthkarList, required this.Screentitle});

  final List<Athkar> AthkarList;
  final String Screentitle;

  @override
  State<AthkarScreen> createState() => _AthkarScreenState();
}

class _AthkarScreenState extends State<AthkarScreen> {
  int currentIndex = 0; // الذكر الحالي
  int counter = 0; // عدد التسبيحات الحالية
   Athkar get currentThikr => widget.AthkarList[currentIndex];
  void incrementCounter() {
    setState(() {
      counter++;
      if (counter >= currentThikr.repeatCount) {
        // ✅ عند الانتهاء من ذكر واحد
        nextThikr();
      }
    });
  }

  void nextThikr() {
    setState(() {
      counter = 0;
      if (currentIndex < widget.AthkarList.length - 1) {
        currentIndex++;
      } else {
        // ✅ عند نهاية جميع الأذكار

        Future.delayed(Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homescreen()),
          );
        });
        Alert(
          context: context,
          type: AlertType.success,
          title: "🎉 ما شاء الله ",
          desc: "لقد أتممت ${widget.Screentitle} كاملة، نسأل الله أن يتقبل منك ",
          buttons: [
            DialogButton(
              color: Colors.lightGreen,
              child: const Text(
                "العودة للرئيسية",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homescreen()),
                );
              },
            ),
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = counter / currentThikr.repeatCount;

    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/logo.png')),

        title: Text(
          "$appname - ${widget.Screentitle}",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[50],
                    borderRadius: BorderRadius.circular(12),
                      
                  ),
                  child: Text(
                    currentThikr.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, height: 1.6,fontWeight: FontWeight.bold),
                  ),
                  height: 200,
                  width: double.infinity,
                   padding: const EdgeInsets.all(16),
             
                ),
                const Spacer( ),
                GestureDetector(
                  onTap: incrementCounter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          valueColor: const AlwaysStoppedAnimation(
                            Colors.lightGreen,
                          ),
                          backgroundColor: const Color.fromARGB(
                            40,
                            158,
                            236,
                            161,
                          ),
                        ),
                      ),
                      Text(
                        "$counter / ${currentThikr.repeatCount}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 100,
                  child: Text(
                    currentThikr.alajer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 98, 125, 79),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Text(
                  "🌿 ذكرٌ يرفعك في الجنة درجة",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
