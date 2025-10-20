import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({
    required this.Screentitle,
    required this.screenicon,
    required this.screendescription,
    required this.onTap,
    super.key,
  });
  final String Screentitle;
  final Widget screenicon;
  final String screendescription;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Screentitle,
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ),
                        
                  SizedBox(height: 8),
                  Text(
                    screendescription,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only( left: 20, top: 40.0),
          child: screenicon,
        ),
      ],
    );
  }
}
