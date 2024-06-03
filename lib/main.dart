import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/controller/setting_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/messages.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dep.init();
  Map<String, Map<String, String>> _languages = await dep.init();
  runApp(MyApp(languages: _languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  MyApp({super.key, required this.languages});
  //MyApp({required this.languages});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PostController>().getAllPostList();
    Get.find<PostController>().getFeaturePostList();
    Get.find<RestaurantController>().getAllRestaurantList();
    Get.find<PlacesController>().getAllPlacesList();
    Get.find<TourController>().getTourList();
    Get.find<SettingController>().getSetting();
    Get.find<TouristAttractionController>()
        .getTouristAttractionList(null, null);
    Get.find<TouristAttractionController>().getTourAttractListPGN(null, null);
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetBuilder<TourController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ba Be Travel',
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: "Lato",
          ),

          //home: Page(),
          locale: localizationController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          initialRoute: RouteHelper.getSplashPage(),
          //initialRoute: RouteHelper.getMenuPage(),
          getPages: RouteHelper.routes,
          defaultTransition: Transition.topLevel,
        );
      });
    });
  }
}
