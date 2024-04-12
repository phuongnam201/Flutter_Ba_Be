import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/controller/setting_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/data/repository/places_repo.dart';
import 'package:flutter_babe/data/repository/post_repo.dart';
import 'package:flutter_babe/data/repository/restaurant_repo.dart';
import 'package:flutter_babe/data/repository/setting_repo.dart';
import 'package:flutter_babe/data/repository/tour_repo.dart';
import 'package:flutter_babe/data/repository/tourist_attraction_repo.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  //SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //apiClient
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //Repository
  Get.lazyPut(() => SettingRepo(apiClient: Get.find()));
  Get.lazyPut(() => TourRepo(apiClient: Get.find()));
  Get.lazyPut(() => TouristAttractionRepo(apiClient: Get.find()));
  Get.lazyPut(() => PostRepo(apiClient: Get.find()));
  Get.lazyPut(() => PlacesRepo(apiClient: Get.find()));
  Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => SettingController(
      settingRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => TourController(tourRepo: Get.find()));
  Get.lazyPut(
      () => TouristAttractionController(touristAttractionRepo: Get.find()));
  Get.lazyPut(() => PostController(postRepo: Get.find()));
  Get.lazyPut(() =>
      PlacesController(placesRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => RestaurantController(
      restaurantRepo: Get.find(), sharedPreferences: Get.find()));
}
