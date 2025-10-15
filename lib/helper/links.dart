import 'package:flutter/material.dart';
import 'package:quran_application/helper/network_helper.dart';
import 'package:quran_application/models/surah.dart';
import 'package:quran_application/utils/api_Urls.dart';

class Links {
  //network helper & ui كلاس عبارة عن حلقة الوصل بين
  //الهدف منو جلب البيانات من الانترنت مرة وحدة واستخدامها وين ما بدي
  // لحتى بس نعمل صفحة ترحيبية تضل تحمل لحد ما تخلص جلب كلشي وما يضل يحمل بين الصفحة والثانية

  NetworkHelper networkHelper = NetworkHelper();

  //  السور
  Future<List<Surah>> getAllSurahs() async {
    // علشان نجيب السور من الانترنت و نحولها الى ليست من نوع سور
    List<Surah> allSurahs = [];

    Map<String, dynamic> data = await networkHelper.fetchAllSurahsData();
    //اخذنا معلومات كل السور وحطيناها هون لحتى يسهل استخدامها
    for (var i = 0; i < data['chapters'].length; i++) {
      allSurahs.add(
        Surah(
          // نموذج بيانات السورة
          // جلب كل معلومة من معلومات السورة وحطها في النموذج
          name: data['chapters'][i]['name_arabic'],
          numberOfAyahs: data['chapters'][i]['verses_count'],
          isMediane: data['chapters'][i]['revelation_place'] == 'madinah'
              ? true
              : false,
          pages: data['chapters'][i]['pages'],
        ),
      );
    }
    return allSurahs;
  }

  // الصفحات لسورة معينة
  Future<List<Image>> getSurahsPage(List<dynamic> pages) async {
    int firstPageNumber = pages[0].toInt();
    int lastPageNumber = pages[1].toInt();

    // علشان نجيب صفحات السورة من خلال رقم الصفحة و نحولها الى ليست من نوع سور
    List<Image> surahsPages = [];
   
     //بلشنا من رقم الصفحة الاولى لحتى نتأكد انو الصفحة محملة 
    for (var i = firstPageNumber; i <= lastPageNumber; i++) {
      // جلب صفحة صفحة من خلال رقم الصفحة 
      //من الصفحة الاولى للسورة الى الصفحة الاخيرة من السورة
      surahsPages.add(
        await networkHelper.getSurahsPageData(i),
      );
      
    }
    return surahsPages;
  }
 }
