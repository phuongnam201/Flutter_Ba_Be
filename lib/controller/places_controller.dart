// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_babe/data/repository/places_repo.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_babe/models/places_model.dart';

class PlacesController extends GetxController implements GetxService {
  final PlacesRepo placesRepo;
  SharedPreferences sharedPreferences;

  List<Places> _placesList = [];
  List<Places> get placesList => _placesList;

  PlacesController({
    required this.placesRepo,
    required this.sharedPreferences,
  });

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAllPlacesList() async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await placesRepo.getAllPlaceInfor(locale: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        _placesList.clear();
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((placesData) {
          Places place = Places.fromJson(placesData);
          _placesList.add(place);
        });

        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
  }
}
