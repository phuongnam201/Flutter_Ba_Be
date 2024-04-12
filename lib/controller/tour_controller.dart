import 'package:flutter_babe/data/repository/tour_repo.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:get/get.dart';

class TourController extends GetxController implements GetxService {
  final TourRepo tourRepo;
  TourController({required this.tourRepo});
  List<Tour> _tourList = [];
  List<Tour> get tourList => _tourList;

  List<String> _images = [];
  List<String> get images => _images;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getTourList() async {
    try {
      Response response = await tourRepo.getTourInfor();
      //print("debug StatusCode at tour controller: " +
      // response.statusCode.toString());
      if (response.statusCode == 200) {
        //print("tour controller is working properly");
        // Clear the list before adding new items
        _tourList.clear();
        // Convert each object in the 'data' array to a Tour object
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((tourData) {
          Tour tour = Tour.fromJson(tourData);
          _tourList.add(tour);
        });
        print(_tourList[0].multiimage.runtimeType);
        _isLoaded = true;
        //_isLoaded = false;
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
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
        // Xóa dấu ngoặc vuông từ đầu và cuối chuỗi
        multiimage = multiimage.substring(1, multiimage.length - 1);
        // Tách chuỗi thành một danh sách các chuỗi, sử dụng dấu "," làm điểm phân cách
        List<String> imageUrls = multiimage.split("\",\"");
        // Lặp qua từng URL ảnh, loại bỏ ký tự dư thừa và thêm vào danh sách images
        for (String imageUrl in imageUrls) {
          // Loại bỏ ký tự dư thừa ở đầu và cuối URL
          imageUrl = imageUrl.replaceAll('"', '');
          images.add(imageUrl);
        }
      }
    }
    return images;
  }
}
