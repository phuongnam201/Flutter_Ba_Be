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

  Future<Restaurant?> getRestaurantDetail(int restaurantID) async {
    Restaurant? restaurant;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await restaurantRepo.getRestaurantDetail(
          restaurantID: restaurantID, language: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        Map<String, dynamic> restaurantData = response.body["results"];
        restaurant = Restaurant.fromJson(restaurantData);
        update();
      } else {
        // Xử lý trường hợp phản hồi không thành công ở đây
        print("Error at restaurant: ${response.statusCode}");
      }
    } catch (e) {
      // Xử lý lỗi khác, chẳng hạn như lỗi kết nối
      print("Error in get Restaurant Detail: $e");
    }
    return restaurant;
  }

  Future<List<String>> getImageList(int restaurantID) async {
    List<String> images = [];
    try {
      // Chờ hàm getRestaurantDetail hoàn thành và trả về một đối tượng Restaurant
      Restaurant? restaurant = await getRestaurantDetail(restaurantID);

      if (restaurant != null) {
        String? multiimage = restaurant.multiimage;
        if (multiimage != null) {
          multiimage = multiimage.substring(1, multiimage.length - 1);
          List<String> imageUrls = multiimage.split("\",\"");
          for (String imageUrl in imageUrls) {
            imageUrl = imageUrl.replaceAll('"', '');
            images.add(imageUrl);
          }
        } else {
          images.add(restaurant.image!);
        }
      }
    } catch (e) {
      print("Error in getImageList: $e");
    }
    return images;
  }
}
