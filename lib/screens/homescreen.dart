import 'package:flutter/material.dart';
import 'package:quran_application/utils/network_helper.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final NetworkHelper networkHelper = NetworkHelper();
  List<dynamic> ayahs = [];
  int pageNumber = 1;
  // bool isLoading = true;

  Future<void> getPage(int pagenumber) async {
    // setState(() => isLoading = true);
    try {
      final data = await networkHelper.getData(pagenumber);
      setState(() {
        ayahs = data;
        // isLoading = false;
      });
    } catch (e) {
      print("Error loading data: $e");
      // setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
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
  }
}
