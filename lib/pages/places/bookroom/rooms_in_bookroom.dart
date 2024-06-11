import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_room_controller.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const List<int> list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

class RoomInBookRoom extends StatefulWidget {
  final int owner_id;
  RoomInBookRoom({super.key, required this.owner_id});

  @override
  State<RoomInBookRoom> createState() => _RoomInBookRoomState();
}

class _RoomInBookRoomState extends State<RoomInBookRoom> {
  final BookRoomController bookRoomController = Get.find<BookRoomController>();

  late RoomsController roomsController;
  List<int> dropdownValues = []; // Lưu trạng thái dropdown cho mỗi item

  @override
  void initState() {
    super.initState();
    roomsController = Get.find<RoomsController>();
    roomsController.getAllRoom(widget.owner_id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomsController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CircularProgressIndicator();
      } else {
        // Khởi tạo giá trị mặc định cho dropdownValues khi dữ liệu đã được load
        if (dropdownValues.length != controller.roomList.length) {
          dropdownValues =
              List<int>.filled(controller.roomList.length, list.first);
        }

        return Container(
          child: ListView.builder(
            itemCount: controller.roomList.length,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getRoomDetail(
                          controller.roomList[index].id!, "hotelDetail"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: roomsController.roomList[index].title!,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Image.network(
                            AppConstants.BASE_URL +
                                "/storage/" +
                                controller.roomList[index].image!,
                            height: Dimensions.height100 * 3,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).disabledColor))),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          BigText(
                            text: 'price'.tr +
                                _formatCurrency(
                                    roomsController.roomList[index].price!) +
                                "/ 1" +
                                "room".tr,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: roomsController.roomList[index].desc!,
                                  color: Colors.blue[800],
                                  size: Dimensions.font16,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                SmallText(
                                  text: "number_of_bed".tr +
                                      controller.roomList[index].numberOfBeds
                                          .toString(),
                                  color: Colors.blue[800],
                                  size: Dimensions.font16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: Dimensions.screenWidth * .3,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber[800]!),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10)),
                    child: Center(
                      child: DropdownButton<int>(
                        value: dropdownValues[index],
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        style: TextStyle(color: Colors.amber[800]),
                        onChanged: (int? value) {
                          print("check number of room: " + value.toString());
                          setState(() {
                            dropdownValues[index] = value!;
                          });
                        },
                        items: list.map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(
                              value.toString() + "room".tr,
                              style: TextStyle(fontSize: Dimensions.font16),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  InkWell(
                    onTap: () {
                      bookRoomController.addRoomToSelection(
                          controller.roomList[index].id.toString(),
                          dropdownValues[index].toString());
                      print("You have just clicked on select this");
                    },
                    child: Container(
                      height: Dimensions.height10 * 5,
                      width: Dimensions.screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.amber[700],
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10)),
                      child: Center(
                          child: SmallText(
                        text: "select_this_room".tr,
                        color: Colors.white,
                        size: Dimensions.font20,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  )
                ],
              ));
            },
          ),
        );
      }
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
