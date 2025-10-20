import 'package:flutter/material.dart';
import 'package:quran_application/screens/surahscreen.dart';

class ListSurahsScreen extends StatefulWidget {
  const ListSurahsScreen({super.key, required this.surahList});
  final List surahList;

  @override
  State<ListSurahsScreen> createState() => _ListSurahsScreenState();
}

class _ListSurahsScreenState extends State<ListSurahsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/logo.png'),
        ),

        title: Text(
          "القرآن الكريم",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        bottom: true,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            itemCount: widget.surahList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ),
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Surahscreen(
                        pages: widget.surahList[index].pages,// [from,to] الصفحات الخاصة بالسورة
                        surahsName: widget.surahList[index].name,
                      ),
                      // الانتقال الى صفحة السورة مع ارسال صفحات السورة و اسم السورة
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.green, width: 1),
                  ),
                  title: Text(
                    "(${index + 1}) سورة ${widget.surahList[index].name} ",
                    style: const TextStyle(fontSize: 20, height: 1.5),
                  ),
                  subtitle: Text(
                    'عدد الآيات: ${widget.surahList[index].numberOfAyahs}',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  trailing: Image(
                    image: AssetImage(
                      widget.surahList[index].isMediane
                          ? 'assets/medinan.png'
                          : 'assets/kaba.png',
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:quran_application/screens/surahscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key, required this.surahList});
  final List surahList;

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/logo.png'),
        ),

        title: Text(
          "القرآن الكريم",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        bottom: true,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            itemCount: widget.surahList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ),
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Surahscreen(
                        pages: widget.surahList[index].pages,// [from,to] الصفحات الخاصة بالسورة
                        surahsName: widget.surahList[index].name,
                      ),
                      // الانتقال الى صفحة السورة مع ارسال صفحات السورة و اسم السورة
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.green, width: 1),
                  ),
                  title: Text(
                    "(${index + 1}) سورة ${widget.surahList[index].name} ",
                    style: const TextStyle(fontSize: 20, height: 1.5),
                  ),
                  subtitle: Text(
                    'عدد الآيات: ${widget.surahList[index].numberOfAyahs}',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  trailing: Image(
                    image: AssetImage(
                      widget.surahList[index].isMediane
                          ? 'assets/medinan.png'
                          : 'assets/kaba.png',
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}






  */