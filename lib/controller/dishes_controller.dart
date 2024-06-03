import 'package:flutter_babe/data/repository/dish_repo.dart';
import 'package:flutter_babe/models/dish_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DishesController extends GetxController implements GetxService {
  final DishRepo dishRepo;
  SharedPreferences sharedPreferences;

  DishesController({required this.dishRepo, required this.sharedPreferences});

  List<Dish> _dishesList = [];
  List<Dish> get dishesList => _dishesList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAllDishes() async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await dishRepo.getAllDishes(locale: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        _dishesList.clear();
        List<dynamic> dataList = response.body['results']['data'];
        //print("check data: " + dataList[0].toString());
        for (int i = 0; i < dataList.length; i++) {
          Dish dish = Dish.fromJson(dataList[i]);
          //print(dish.title);
          _dishesList.add(dish);
        }
      }
      update();
    } catch (e) {
      print("Error in get all dishes: $e");
    }
  }

  Future<Dish?> getDishDetail(int dishID) async {
    Dish? dish;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await dishRepo.getDishDetail(dishID: dishID, language: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        Map<String, dynamic> placeData = response.body["results"];
        // Tạo một đối tượng restaurant từ dữ liệu của nhà hàng
        dish = Dish.fromJson(placeData);
        update();
      } else {
        // Xử lý trường hợp phản hồi không thành công ở đây
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // Xử lý lỗi khác, chẳng hạn như lỗi kết nối
      print("Error in get dishes Detail: $e");
    }
    return dish;
  }
}
