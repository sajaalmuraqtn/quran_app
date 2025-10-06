import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_application/utils/api_Urls.dart';

// احضار صورة الصفحة نفسها من الانترنت وعرضها حسب رقم الصفحة
class NetworkHelper {
  Future<dynamic> getSurahsPageData(int pageNumber) async {
    http.Response response = await http.get(Uri.parse('$baseUrlPagesImage'));
    //لحتى يجيبلي الداتا  http requestامر موجود في ال -> get
 
    if (response.statusCode == 200) {
      // 200 -> request يعني اذا نجح ال
      Image pageImage = Image(image: NetworkImage(
        '$baseUrlPagesImage/${pageNumber < 10
                ? '00'
                : pageNumber < 100
                ? '0'
                : ''}${pageNumber}.png',
      ));
       // رح يجيبلي صورة الصفحة من الانترنت حسب رقم الصفحة
      return pageImage;
    } else {
      Future.error('error in fetching data');
      //requestبحالة فشل ال
    }
  }

  Future<Map<String, dynamic>> fetchAllSurahsData() async {
    var response = await http.get(Uri.parse(baseUrlAllSurahs));
    //jsonDecode  ->   mapل json string بيحوللي ال

    if (response.statusCode == 200) {
       return json.decode(response.body);
      //  رح يرجعلي كل معلومات السور
    } else {
      return Future.error('error in fetching data');
    }
  }

  Future<List<dynamic>> fetchAyahs(int pageNumber) async {
    var response = await http.get(
      Uri.parse('http://api.alquran.cloud/v1/page/$pageNumber/quran-uthmani'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body['data']['ayahs'];
    } else {
      return Future.error('error in fetching data');
    }
  }
}
 
 /*
class NetworkHelper {
  Future<dynamic> getData(int pagenumber) async {
    try {}
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
*/