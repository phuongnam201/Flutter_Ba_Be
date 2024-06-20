import 'package:flutter_babe/data/repository/search_repo.dart';
import 'package:flutter_babe/models/places_model.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultController extends GetxController implements GetxService {
  SearchResultRepo searchResutlRepo;
  SharedPreferences sharedPreferences;

  SearchResultController(
      {required this.searchResutlRepo, required this.sharedPreferences});

  List<Tour> _tours = [];
  List<Tour> get tours => _tours;

  List<Post> _post = [];
  List<Post> get post => _post;

  List<Places> _places = [];
  List<Places> get places => _places;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  String? _type = '';
  String? get type => _type;

  Future<void> getResultSearch(String type, String keyword) async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      _type = type;
      if (!keyword.isEmpty) {
        Response response = await searchResutlRepo.search(
            locale: language, type: type, keyword: keyword);
        if (response.statusCode == 200) {
          _isLoaded = true;
          List<dynamic> dataList = response.body['results'];
          print("check data get from seacrh controller:" +
              dataList.length.toString());
          if (type == 'tours') {
            _tours = dataList.map((element) => Tour.fromJson(element)).toList();
          } else if (type == 'news') {
            _post = dataList.map((element) => Post.fromJson(element)).toList();
          } else if (type == 'places') {
            _places =
                dataList.map((element) => Places.fromJson(element)).toList();
          }
          //print(_tours.length);
        }
      }
      update();
    } catch (e) {
      print("Error in get all room: $e");
    }
  }
}
