import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Masbahascreen extends StatefulWidget {
  Masbahascreen({super.key});

  @override
  State<Masbahascreen> createState() => _MasbahascreenState();
}

class _MasbahascreenState extends State<Masbahascreen> {
  int counter = 0; // عداد المسبحة
  int progress = 100; // التقدم في المسبحة

  void resetCounter() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "هل أنت متأكد؟",
      desc: "سيتم إعادة تعيين المسبحة إلى الصفر.",
      buttons: [
        DialogButton(
          color: Colors.red,
          child: Text(
            "نعم متأكد",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              counter = 0;
              progress = 100;
            });
          },
          width: 120,
        ),
      ],
    ).show();

  }

  void incrementCounter() {
    counter++;
    if (counter > progress) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "ما أجمل قلباً لا يملّ من ذكر الله",
        desc: "لقد أكملت المسبحة.",
        buttons: [
          DialogButton(
            color: Colors.red,
            child: Text(
              "إعادة الذكر",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              resetCounter();
            },
            width: 120,
          ),
          DialogButton(
            color: Colors.lightGreen,
            child: Text(
              "إكمال الذكر",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          ),
        ],
      ).show();
      progress += 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/logo.png')),

        title: Text(
          " المسبحة الإلكترونية - القرآن الكريم",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
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
        bottom: true,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      incrementCounter();
                    });
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightGreen,
                          ),
                          strokeWidth: 6.0,
                          backgroundColor: const Color.fromARGB(
                            37,
                            158,
                            236,
                            161,
                          ),
                          value: counter.toDouble() / progress.toDouble(),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${counter}',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    resetCounter();
                  });
                },
                child: Text(
                  'أعد الذكر من جديد',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 100),
               Text(
                 "خطوة صغيرة في الذكر .. وأجرٌ عظيم في الميزان",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
             ],
          ),
        ),
      ),
    );
  }
}
