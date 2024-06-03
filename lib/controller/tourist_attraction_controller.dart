import 'package:flutter_babe/data/repository/tourist_attraction_repo.dart';
import 'package:flutter_babe/models/tourist_attraction_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TouristAttractionController extends GetxController
    implements GetxService {
  final TouristAttractionRepo touristAttractionRepo;
  SharedPreferences sharedPreferences;

  TouristAttractionController({
    required this.touristAttractionRepo,
    required this.sharedPreferences,
  });

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 1;
  int get totalPage => _totalPage;

  List<TouristAttraction> _touristAttractionList = [];
  List<TouristAttraction> get touristAttractionList => _touristAttractionList;

  List<TouristAttraction> _touristAttractionOther = [];
  List<TouristAttraction> get touristAttractionOther => _touristAttractionOther;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getTouristAttractionList(int? paginate, int? page) async {
    try {
      String? language =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
      Response response = await touristAttractionRepo.getTouristAttractionInfor(
          locale: language, paginate: paginate, page: page);
      if (response.statusCode == 200) {
        _isLoaded = true;
        _touristAttractionList.clear();
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((tourData) {
          TouristAttraction touristAttraction =
              TouristAttraction.fromJson(tourData);
          _touristAttractionList.add(touristAttraction);
        });
        //_isLoaded = false;
        update();
      } else {}
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTouristAttractionList: $e");
    }
  }

  Future<void> getTourAttractListPGN(int? paginate, int? page) async {
    try {
      String? language =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
      Response response = await touristAttractionRepo.getTouristAttractionInfor(
          locale: language, paginate: paginate, page: page);
      if (response.statusCode == 200) {
        _isLoaded = true;
        _touristAttractionOther.clear();
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((tourData) {
          TouristAttraction touristAttraction =
              TouristAttraction.fromJson(tourData);
          _touristAttractionOther.add(touristAttraction);
        });
        //_isLoaded = false;

        _currentPage = page!;
        print("check pgn at tourAttract: " +
            _touristAttractionOther.length.toString());
        update();
      } else {}
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourAttractListPGN: $e");
    }
  }

  TouristAttraction getTouristAttraction(int id) {
    for (TouristAttraction tour in _touristAttractionList) {
      if (tour.id == id) {
        return tour;
      }
    }
    return TouristAttraction();
  }
}
