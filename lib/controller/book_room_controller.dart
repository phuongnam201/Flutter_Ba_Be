import 'package:flutter/material.dart';
import 'package:flutter_babe/data/repository/book_room_repo.dart';
import 'package:flutter_babe/models/book_room_model.dart';
import 'package:flutter_babe/models/response_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:get/get.dart';

class BookRoomController extends GetxController implements GetxService {
  final BookRoomRepo bookRoomRepo;

  BookRoomController({required this.bookRoomRepo});

  int _adults = 2;
  int _children = 0;

  int get adults => _adults;
  int get children => _children;

  BookRoomModel? _bookRoomModel;
  BookRoomModel? get bookRoomModel => _bookRoomModel;

  List<RoomsSelected> _roomsSelectedList = [];
  List<RoomsSelected> get roomsSelectedList => _roomsSelectedList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> bookRoom(BookRoomModel bookRoomModel) async {
    _isLoading = true;
    late ResponseModel responseModel;
    update();
    try {
      Response response = await bookRoomRepo.bookRoomInRepo(bookRoomModel);
      print("Check status code at book room controller " +
          response.body.toString());

      if (response.statusCode == 200) {
        print("success!");
        print(response.body);
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        responseModel = ResponseModel(false, response.body[0]);
      }

      _isLoading = false;
      update();
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      Get.offNamed(RouteHelper.getSignInPage());
    }

    return responseModel;
  }

  void clearRoomsSelected() {
    _roomsSelectedList.clear();
    update();
  }

  String? getRoomNumberById(String roomId) {
    for (RoomsSelected room in _roomsSelectedList) {
      if (room.roomId == roomId) {
        return room.number;
      }
    }
    return null; // or you could return '0' if you prefer
  }

  void removeRoomFromSelection(String roomId) {
    _roomsSelectedList.removeWhere((room) => room.roomId == roomId);
    update();
  }

  void addRoomToSelection(String roomId, String number) {
    bool found = false;
    for (int i = 0; i < _roomsSelectedList.length; i++) {
      if (_roomsSelectedList[i].roomId == roomId) {
        int newNumber =
            int.parse(_roomsSelectedList[i].number!) + int.parse(number);
        _roomsSelectedList[i] =
            RoomsSelected(roomId: roomId, number: newNumber.toString());
        found = true;
        break;
      }
    }
    if (!found) {
      RoomsSelected room = RoomsSelected(roomId: roomId, number: number);
      _roomsSelectedList.add(room);
    }
    update();
  }

  void updateQuantityAdults(int number, BuildContext context) {
    if (_adults + number < 1) {
      _showAlertDialog(context, "warning_content_number_adults".tr);
    } else {
      _adults += number;
      update();
    }
  }

  void updateQuantityChildren(int number, BuildContext context) {
    if (_children + number < 0) {
      _showAlertDialog(context, "warning_content_number_children".tr);
    } else {
      _children += number;
      update();
    }
  }

  void setQuantityAdults(int quantity, BuildContext context) {
    if (quantity <= 0) {
      _adults = 0;
      _showAlertDialog(context, "adults_validate".tr);
    } else {
      _adults = quantity;
      update();
    }
  }

  void setQuantityChildren(int quantity, BuildContext context) {
    if (quantity < 0) {
      _showAlertDialog(context, "children_validate".tr);
      _children = 0;
    } else {
      _children = quantity;
      update();
    }
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('warning'.tr)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
