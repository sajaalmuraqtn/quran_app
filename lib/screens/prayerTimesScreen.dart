import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quran_application/utils/api_Urls.dart';
import 'package:quran_application/utils/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:uni_country_city_picker/uni_country_city_picker.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  Map<String, String> prayerTimes = {};
  bool isLoadingTimes = false;

  String? selectedCountry;
  String? selectedCity;

  List<Country> countriesAndCities = [];
  final _uniCountryServices = UniCountryServices.instance;

  @override
  void initState() {
    super.initState();
    _loadCountriesAndCities();
    fetchPrayerTimes();
  }

  Future<void> _loadCountriesAndCities() async {
    countriesAndCities = await _uniCountryServices.getCountriesAndCities();
    setState(() {});
  }

  Future<void> fetchPrayerTimes({String city="jerusalem", String country="palestine"}) async {
    setState(() => isLoadingTimes = true);

    final url = Uri.parse(
        "$baseUrlPrayerTime?city=$city&country=$country&method=2");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = Map<String, String>.from(data["data"]["timings"]);

        setState(() {
          prayerTimes = timings;
          isLoadingTimes = false;
        });
      } else {
        throw Exception("Failed to load prayer times");
      }
    } catch (e) {
      setState(() => isLoadingTimes = false);
      Alert(
        context: context,
        type: AlertType.error,
        title: "خطأ",
        desc: "تعذر تحميل مواقيت الصلاة" ,
        buttons: [
          DialogButton(
            color: primaryColor,
            child: const Text("حسناً", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ).show();
    }
  }

  List<String> getCitiesForSelectedCountry() {
    if (selectedCountry == null) return [];
    final country =
        countriesAndCities.firstWhere((c) => c.nameEn == selectedCountry);
    return country.cities.map((city) => city.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Image(image: AssetImage('assets/logo.png')),
        title: Text(
          "$appname - مواقيت الصلاة",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // الانتظار أثناء تحميل الدول
                if (countriesAndCities.isEmpty)
                  const Center(child: CircularProgressIndicator(color: Colors.teal))
                else ...[
                   DropdownButtonFormField<String>(
                    decoration: InputDecoration( 
                      labelText: "اختر الدولة",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    value: selectedCountry,
                    items: countriesAndCities
                        .map((c) => DropdownMenuItem(
                              value: c.nameEn,
                              child: Text(c.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                        selectedCity = null; // إعادة تعيين المدينة
                        prayerTimes.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                   DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "اختر المدينة",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    value: selectedCity,
                    items: getCitiesForSelectedCountry()
                        .map((cityName) => DropdownMenuItem(
                              value: cityName,
                              child: Text(cityName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                        if (selectedCity != null && selectedCountry != null) {
                          fetchPrayerTimes(city:  selectedCity!,country:  selectedCountry!);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // عرض مواقيت الصلاة
                  if (isLoadingTimes)
                      Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      ),
                    )
                  else if (prayerTimes.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          "الرجاء اختيار المدينة لعرض مواقيت الصلاة",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView(
                        children: prayerTimes.entries.map((entry) {
                          final arabicNames = {
                            "Fajr": "الفجر",
                            "Sunrise": "الشروق",
                            "Dhuhr": "الظهر",
                            "Asr": "العصر",
                            "Maghrib": "المغرب",
                            "Isha": "العشاء",
                            "Sunset": "الغروب",
                            "Imsak": "العشاء",
                            "Midnight": "الإمساك",
                            "Firstthird": "الثلث الأول",
                            "Lastthird": "الثلث الأخير",
                          };
          
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: Icon(Icons.access_time,
                                  color: primaryColor, size: 28),
                              title: Text(
                                arabicNames[entry.key] ?? entry.key,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                entry.value,
                                style:   TextStyle(
                                    fontSize: 18, color:Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
