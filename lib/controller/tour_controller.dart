import 'package:flutter_babe/data/repository/tour_repo.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TourController extends GetxController implements GetxService {
  final TourRepo tourRepo;
  SharedPreferences sharedPreferences;

  TourController({required this.tourRepo, required this.sharedPreferences});
  List<Tour> _tourList = [];
  List<Tour> get tourList => _tourList;

  List<String> _images = [];
  List<String> get images => _images;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getTourList() async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await tourRepo.getTourInfor(locale: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        _tourList.clear();
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((tourData) {
          Tour tour = Tour.fromJson(tourData);
          _tourList.add(tour);
        });
        //print('tour created:' + _tourList[0].createdAt.toString());
        update();
      } else {}
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
  }

  Tour getTourDetail(int tourID) {
    for (Tour tour in _tourList) {
      if (tour.id == tourID) {
        return tour;
      }
    }
    return Tour();
  }

  List<String> getImageList(int tourID) {
    Tour tour = getTourDetail(tourID);
    List<String> images = [];

    if (tour != null) {
      String? multiimage = tour.multiimage;
      if (multiimage != null) {
        multiimage = multiimage.substring(1, multiimage.length - 1);
        List<String> imageUrls = multiimage.split("\",\"");
        for (String imageUrl in imageUrls) {
          imageUrl = imageUrl.replaceAll('"', '');
          images.add(imageUrl);
        }
      }
    }
    return images;
  }
}
