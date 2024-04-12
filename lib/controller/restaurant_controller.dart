// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_babe/data/repository/restaurant_repo.dart';
import 'package:flutter_babe/models/restaurant_model.dart';
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
    try {
      Response response = await restaurantRepo.getAllRestaurantInfor();
      print("debug StatusCode at restaurant controller: " +
          response.statusCode.toString());
      if (response.statusCode == 200) {
        _isLoaded = true;
        // print("post controller is working properly");
        // Clear the list before adding new items
        _restaurantList.clear();
        // Convert each object in the 'data' array to a Tour object
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((restaurantData) {
          Restaurant restaurant = Restaurant.fromJson(restaurantData);
          _restaurantList.add(restaurant);
        });
        print("restaurant list get from api:" + _restaurantList.toString());
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in get Restaurant List: $e");
    }
  }
}
