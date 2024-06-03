import 'package:flutter_babe/models/languages.dart';

class AppConstants {
  static const APP_NAME = "babe_app";
  static const APP_VERSION = 1;
  static const String BASE_URL = "https://vrbabe.kennatech.vn/";

  //no auth
  static const String SETTING_URL = "api/v1/settings?language=";
  static const String CONTACT_URL = "api/v1/contacts";
  static const String TOUR_URL = "api/v1/tours";
  static const String TOURIST_ATTRACTION_URL = "api/v1/locations";
  static const String POST_URL = "api/v1/posts";
  static const String PLACES_URL = "api/v1/places";
  static const String RESTAURANT_URL = "api/v1/restaurants";
  static const String ROOM_URL = "api/v1/rooms";
  static const String DISH_URL = "api/v1/dishes";
  static const String ABOUT_US_URL = "api/v1/pages/ve-chung-toi";
  static const String USER_INFORMATION_URL = "api/v1/customer";

  //auth
  static const String REGISTER_URL = "api/v1/auth/register";
  static const String LOGIN_URL = "api/v1/auth/login";
  static const String EMAIL = "";
  static const String PASSWORD = "";
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
