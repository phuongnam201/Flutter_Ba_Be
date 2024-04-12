import 'package:flutter_babe/data/repository/tourist_attraction_repo.dart';
import 'package:flutter_babe/models/tourist_attraction_model.dart';
import 'package:get/get.dart';

class TouristAttractionController extends GetxController
    implements GetxService {
  final TouristAttractionRepo touristAttractionRepo;
  TouristAttractionController({required this.touristAttractionRepo});
  List<TouristAttraction> _touristAttractionList = [];
  List<TouristAttraction> get touristAttractionList => _touristAttractionList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getTouristAttractionList() async {
    try {
      Response response =
          await touristAttractionRepo.getTouristAttractionInfor();
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
      print("Error in getTourList: $e");
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
