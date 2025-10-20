import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_application/models/surah.dart';
import 'package:quran_application/utils/api_Urls.dart';

class NetworkHelper {
  // جلب كل السور من الانترنت
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

  // احضار صورة الصفحة نفسها من الانترنت وعرضها حسب رقم الصفحة

  Future<CachedNetworkImage?> getSurahsPageData(int pageNumber) async {
    http.Response response = await http.get(Uri.parse('$baseUrlPagesImage'));
    //لحتى يجيبلي الداتا  http requestامر موجود في ال -> get

    if (response.statusCode == 200) {
      // 200 -> request يعني اذا نجح ال
      CachedNetworkImage pageImage = await CachedNetworkImage(
        imageUrl:
            '$baseUrlPagesImage/${pageNumber < 10
                ? '00'
                : pageNumber < 100
                ? '0'
                : ''}${pageNumber}.png',
        errorWidget: (context, baseUrlPagesImage, error) => Icon(Icons.error),
        fit: BoxFit.contain,
      );
      //CachedNetworkImage استخدام مكتبة
      // السبب انو تحميل الصور من الانترنت بياخد وقت وهيذه المكتبة بتساعدني
      // انو تعرضلي صورة مؤقتة لحتى تحمل الصورة الاساسية

      // رح يجيبلي صورة الصفحة من الانترنت حسب رقم الصفحة
      return pageImage;
    } else {
      Future.error('error in fetching data');
      //requestبحالة فشل ال
    }
  }

  //  جلب آيات صفحة معينة من خلال رقم الصفحة
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