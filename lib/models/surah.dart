
class Surah {
  // نموذج بيانات السورة
   final String name; 
  final int numberOfAyahs;
  final bool isMediane;
  final List<dynamic> pages; //[from,to] الصفحات الخاصة بالسورة 
  

  Surah({
     required this.name,
     required this.numberOfAyahs,
     required this.isMediane,
     required this.pages,
  });
 
}

class Verse {
  final int surah;
  final int ayah;
  final String text;
  final String audio;

  Verse({
    required this.surah,
    required this.ayah,
    required this.text,
    required this.audio,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      surah: json['surah'],
      ayah: json['ayah'],
      text: json['text'],
      audio: json['audio'] ?? '',
    );
  }
}