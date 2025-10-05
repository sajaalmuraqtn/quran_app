import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<dynamic> getData(int pagenumber) async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://api.alquran.cloud/v1/page/$pagenumber/quran-uthmani'),
      );
      //لحتى يجيبلي الداتا  http requestامر موجود في ال -> get 
        Map<String, dynamic> body = jsonDecode(response.body);
         //jsonDecode  ->   mapل json string بيحوللي ال  

      if (response.statusCode == 200) {
        // 200 -> request يعني اذا نجح ال 
       
        List <dynamic> ayah = body['data']['ayahs'];
        //  ayah  ->  List of map  في عندي داتا عبارة عن
        return ayah;
      }
      else {
         Future.error('error in fetching data');
         //requestبحالة فشل ال
        }
    } catch (e) {
      print(e);
      // Handle error
    }
  }
}
