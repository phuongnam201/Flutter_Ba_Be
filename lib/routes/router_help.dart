import 'package:flutter_babe/pages/about/about_us_page.dart';
import 'package:flutter_babe/pages/auth/sign_in_page.dart';
import 'package:flutter_babe/pages/auth/sign_up_page.dart';
import 'package:flutter_babe/pages/contact/contact_page.dart';
import 'package:flutter_babe/pages/home/home_page.dart';
import 'package:flutter_babe/pages/home/menu_page.dart';
import 'package:flutter_babe/pages/language/languages_page.dart';
import 'package:flutter_babe/pages/map/map_page.dart';
import 'package:flutter_babe/pages/news/news_detail/news_detail.dart';
import 'package:flutter_babe/pages/news/news_page.dart';
import 'package:flutter_babe/pages/notification/notification_page.dart';
import 'package:flutter_babe/pages/search/search_page.dart';
import 'package:flutter_babe/pages/splash/splash_page.dart';
import 'package:flutter_babe/pages/tour/tour_detail/tour_detail.dart';
import 'package:flutter_babe/pages/tour/tour_page.dart';
import 'package:flutter_babe/pages/tourist_attraction/tourist_attraction.dart';
import 'package:flutter_babe/pages/tourist_attraction/tourist_attraction_detail.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String menuPage = "/menu-page";
  static const String homePage = "/home-page";
  static const String language = '/language';
  static const String mapPage = "/map-page";
  static const String signInPage = "/signIn-page";
  static const String signUpPage = "/signUp-page";
  static const String notificationPage = "/notification-page";
  static const String aboutUsPage = "/aboutUs-page";
  static const String newsPage = "/news-page";
  static const String searchPage = "/search-page";
  static const String tourPage = "/tour-page";
  static const String contactPage = "/contact-page";
  static const String tourDetailPage = "/tourDetail-page";
  static const String newsDetailPage = "/newsDetail-page";
  static const String touristAttractionPage = "/touristAttraction-page";
  static const String touristAttractionDetailPage =
      "/touristAttractionDetail-page";

  static String getSplashPage() => '$splashPage';
  static String getMenuPage() => '$menuPage';
  static String getMapPage() => '$mapPage';
  static String getHomePage() => '$homePage';
  static String getSignInPage() => '$signInPage';
  static String getSignUpPage() => '$signUpPage';
  static String getNotificationPage() => '$notificationPage';
  static String getLanguageRoute() => '$language';
  static String getAboutUsPage() => '$aboutUsPage';
  static String getNewsPage() => '$newsPage';
  static String getSearchPage() => '$searchPage';
  static String getTourPage() => '$tourPage';
  static String getContactPage() => '$contactPage';
  static String getTourDetailPage(int tourID, String pageID) =>
      '$tourDetailPage?tourID=$tourID&pageID=$pageID';
  static String getNewsDetailPage(int postID, String pageID) =>
      '$newsDetailPage?postID=$postID&pageID=$pageID';
  static String getTouristAttractionPage() => '$touristAttractionPage';
  static String getTouristAttractionDetailPage(
          int tourAttractionID, String pageID) =>
      '$touristAttractionDetailPage?tourAttractionID=$tourAttractionID&pageID=$pageID';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: menuPage, page: () => MenuPage()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: mapPage, page: () => MapPage()),
    GetPage(name: signInPage, page: () => SignInPage()),
    GetPage(name: signUpPage, page: () => SignUpPage()),
    GetPage(name: notificationPage, page: () => NotificationPage()),
    GetPage(name: aboutUsPage, page: () => AboutUsPage()),
    GetPage(name: newsPage, page: () => NewPage()),
    GetPage(name: newsPage, page: () => SearchPage()),
    GetPage(name: tourPage, page: () => TourPage()),
    GetPage(name: contactPage, page: () => ContactPage()),
    GetPage(
        name: tourDetailPage,
        page: () {
          var tourID = Get.parameters['tourID'];
          var pageID = Get.parameters['pageID'];
          return TourDetail(tourID: int.parse(tourID!), pageID: pageID!);
        }),
    GetPage(
        name: newsDetailPage,
        page: () {
          var postID = Get.parameters['postID'];
          var pageID = Get.parameters['pageID'];
          return NewsDetail(postID: int.parse(postID!), pageID: pageID!);
        }),
    GetPage(name: touristAttractionPage, page: () => TouristAttractionPage()),
    GetPage(
        name: touristAttractionDetailPage,
        page: () {
          var tourAttractionID = Get.parameters['tourAttractionID'];
          var pageID = Get.parameters['pageID'];
          return TouristAttractionDetailPage(
            tourAttractionID: int.parse(tourAttractionID!),
            pageID: pageID!,
          );
        }),
    GetPage(
        name: language,
        page: () {
          return LanguagePage();
        })
  ];
}
