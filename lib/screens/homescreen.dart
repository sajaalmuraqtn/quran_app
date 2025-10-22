import 'package:flutter/material.dart';
import 'package:quran_application/models/masaandsabahathkar.dart';
import 'package:quran_application/screens/loadingscreen.dart';
import 'package:quran_application/screens/athkar.dart';
import 'package:quran_application/screens/masbahascreen.dart';
import 'package:quran_application/utils/constants.dart';
  import 'package:quran_application/widgets/screen_widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/logo.png')),

        title: Text(
          "النور ",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        bottom: true,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: const EdgeInsets.all(10),
             children: [
                   ScreenWidget(
                Screentitle: "القرآن الكريم",
                screenicon: Icon(
                  Icons.book,
                  size: 80,
                  color: const Color.fromARGB(255, 17, 255, 25),
                ),
                screendescription: " تلاوة القرآن تضيء القلب وتمنح السكينة.",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoadingScreen()),
                  );
                },
              ),
              ScreenWidget(
                Screentitle: "أذكار الصباح",
                screenicon: Icon(Icons.sunny, size: 80, color: Colors.yellow),
                screendescription:
                    '   صباحك نورٌ بالذكر وطمأنينة بالقُرب من الله.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AthkarScreen(AthkarList: sabahAthkarList, Screentitle: "أذكار الصباح")),
                  );
                },
              ),
              ScreenWidget(
                Screentitle: "أذكار المساء",
                screenicon: Icon(Icons.dark_mode, size: 80, color: Colors.blue),
                screendescription: " اجعل ختام يومك نوراً بذكر الرحمن.",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AthkarScreen(AthkarList: MasaAthkarList, Screentitle: "أذكار المساء")),
                  );
                },
              ),
         
              ScreenWidget(
                Screentitle: "أذكار النوم",
                screenicon: Icon(
                  Icons.bed_rounded,
                  size: 80,
                  color: Colors.brown,
                ),
                screendescription: "اذكر ربك، فبِذكره تطمئن القلوب.",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AthkarScreen(AthkarList: SleepAthkarList, Screentitle: "أذكار النوم")),
                  );
                },
              ),
              ScreenWidget(
                Screentitle: " المسبحة الإلكترونية",
                screenicon: Icon(
                  Icons.hourglass_full_outlined,
                  size: 80,
                  color: Colors.pink,
                ),
                screendescription: "اذكر ربك، فبِذكره تطمئن القلوب.",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Masbahascreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
