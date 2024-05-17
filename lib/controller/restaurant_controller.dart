// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_babe/data/repository/restaurant_repo.dart';
import 'package:flutter_babe/models/restaurant_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantController extends GetxController implements GetxService {
  final RestaurantRepo restaurantRepo;
  SharedPreferences sharedPreferences;

  List<Restaurant> _restaurantList = [];
  List<Restaurant> get restaurantList => _restaurantList;

  RestaurantController({
    required this.restaurantRepo,
    required this.sharedPreferences,
  });

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAllRestaurantList() async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await restaurantRepo.getAllRestaurantInfor(locale: language);
      //print("debug StatusCode at restaurant controller: " +
      //response.statusCode.toString());
      if (response.statusCode == 200) {
        _isLoaded = true;
        _restaurantList.clear();
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((restaurantData) {
          Restaurant restaurant = Restaurant.fromJson(restaurantData);
          _restaurantList.add(restaurant);
        });
        //print("restaurant list get from api:" + _restaurantList.toString());
        update();
      } else {}
    } catch (e) {
      print("Error in get Restaurant List: $e");
    }
  }
}
