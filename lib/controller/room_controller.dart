import 'package:flutter_babe/data/repository/room_repo.dart';
import 'package:flutter_babe/models/room_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomsController extends GetxController implements GetxService {
  final RoomRepo roomRepo;
  SharedPreferences sharedPreferences;

  RoomsController({required this.roomRepo, required this.sharedPreferences});

  List<Room> _roomList = [];
  List<Room> get roomList => _roomList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAllRoom() async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await roomRepo.getAllRoom(locale: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        _roomList.clear();
        List<dynamic> dataList = response.body['results'];
        dataList.forEach((element) {
          Room room = Room.fromJson(element);
          _roomList.add(room);
        });
      }
      update();
    } catch (e) {
      print("Error in get all room");
    }
  }

  Future<Room?> getPlaceDetail(int roomID) async {
    Room? room;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await roomRepo.getRoomDetail(roomID: roomID, language: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        Map<String, dynamic> placeData = response.body["results"];
        // Tạo một đối tượng restaurant từ dữ liệu của nhà hàng
        room = Room.fromJson(placeData);
        update();
      } else {
        // Xử lý trường hợp phản hồi không thành công ở đây
        print("Error at room controller: ${response.statusCode}");
      }
    } catch (e) {
      // Xử lý lỗi khác, chẳng hạn như lỗi kết nối
      print("Error in get Restaurant Detail: $e");
    }
    return room;
  }
}
