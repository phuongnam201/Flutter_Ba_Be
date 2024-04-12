import 'package:flutter_babe/models/languages.dart';

class AppConstants {
  static const APP_NAME = "babe_app";
  static const APP_VERSION = 1;
  static const String BASE_URL = "";

  static const String SETTING_URL = "api/v1/settings?language=";
  static const String CONTACT_URL = "api/v1/contacts";
  static const String TOUR_URL = "api/v1/tours/";
  static const String TOURIST_ATTRACTION_URL = "api/v1/locations";
  static const String POST_URL = "api/v1/posts";
  static const String PLACES_URL = "api/v1/places";
  static const String RESTAURANT_URL = "api/v1/restaurants";
  // static const String SETTING_URL = "api/v1/settings?language=";
  // static const String SETTING_URL = "api/v1/settings?language=";
  // static const String SETTING_URL = "api/v1/settings?language=";
  /*
  Localization data
   */
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: "xx",
        languageName: 'English',
        countryCode: 'EN',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: "xx",
        languageName: 'Việt Nam',
        countryCode: 'VN',
        languageCode: 'vi'),
  ];

  static const String TOKEN = '';
}
