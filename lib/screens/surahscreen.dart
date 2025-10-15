
import 'package:flutter/material.dart';
import 'package:quran_application/helper/links.dart';
import 'package:quran_application/helper/network_helper.dart';
import 'package:quran_application/utils/api_Urls.dart';

class Surahscreen extends StatefulWidget {
    Surahscreen({super.key, required this.pages, required this.surahsName});

  final List<dynamic> pages;
  final String surahsName;
  // final List<dynamic> surahsPages = [];

  @override
  State<Surahscreen> createState() => _SurahscreenState();
}

class _SurahscreenState extends State<Surahscreen> {
  final NetworkHelper networkHelper = NetworkHelper();
 bool isLoading = true;

  Links links = Links();
  late Future<List<Image>> futruePages ;
  @override
  void initState() {
    super.initState();
    futruePages = links.getSurahsPage(widget.pages);



    // links.getSurahsPage(widget.pages).then((pages) {
    // setState(() {
    //   isLoading = false;
    //    widget.surahsPages.addAll(pages);
    //   //  هون بضيف كل الصفحات اللي جبتها من الانترنت الى ليست الصفحات الخاصة بالسورة لحتى نعرضها
    // });
    //  });
  }

  @override
  
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        leading: const Image(image: AssetImage('assets/logo.png'), height: 50, width: 50,),
        title: Text(
          " سورة ${widget.surahsName} - القرآن الكريم",
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
         
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:
              Padding(
                padding: const EdgeInsets.symmetric(vertical:30.0),
                child: 
                
                FutureBuilder <List<Image>>(
                  future:futruePages,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // اذا لسا البيانات عم تحمل
                      return const Center(child: CircularProgressIndicator(color: Colors.green));
                    } else if (snapshot.hasError) {
                      // اذا صار في خطأ بجلب البيانات
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // اذا ما في بيانات متاحة
                      return const Center(child: Text('No data available'));
                    } else {
                      // اذا تم جلب البيانات بنجاح
                      final pages = snapshot.data!;
                      // هون بضيف كل الصفحات اللي جبتها من الانترنت الى ليست الصفحات الخاصة بالسورة لحتى نعرضها
                      return PageView.builder(
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          return pages[index];
                          //  الصور اللي جبتها من الانترنت
                        },
                      );
                    }
                  },
                )
 
              ),
        ),
      ),
    );
  } 
}

/*
here is the previous version of the code before the latest edit with out future builder: 
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        leading: const Image(image: AssetImage('assets/logo.png'), height: 50, width: 50,),
        title: Text(
          " سورة ${widget.surahsName} - القرآن الكريم",
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
         
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:
              // const Center(child: CircularProgressIndicator(color: Colors.green))
              Padding(
                padding: const EdgeInsets.symmetric(vertical:30.0),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.green))
                    : PageView.builder(
                  itemCount: widget.surahsPages.length,
                  itemBuilder: (context, index) {
                    return  widget.surahsPages[index];
                }
                ),
              ),
        ),
      ),
    );
  } 
} */



/*
get the ayahs of a specific page

Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.nightlight_round_outlined,
          color: Colors.white,
        ),
        title: Text(
          ayahs.isNotEmpty ? ayahs[0]['surah']['name'] : 'جاري التحميل...',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        bottom: true,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:
              // const Center(child: CircularProgressIndicator(color: Colors.green))
              PageView.builder(
                itemCount: 604,
                itemBuilder: (context, index) {
                  getPage(index + 1); // تحميل الصفحة الجديدة

                  return Column(
                    children: [
                      Wrap(
                        spacing: 10, //مسافة بين الازرار
                        runSpacing: 10, //سطر جديد

                        children: [
                          for (int i = 0; i < ayahs.length; i++)
                            Text(
                              " ${ayahs[i]['text']}،",
                              style: TextStyle(fontSize: 20),
                            ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        "الصفحة رقم ${index + 1}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }*/