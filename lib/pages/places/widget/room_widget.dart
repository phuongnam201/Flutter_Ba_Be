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

class RoomWidget extends StatefulWidget {
  final int placeID;
  final int ownerID;
  RoomWidget({Key? key, required this.ownerID, required this.placeID})
      : super(key: key);

  @override
  State<RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  late RoomsController roomsController;
  final BookRoomController bookRoomController = Get.find<BookRoomController>();

  @override
  void initState() {
    super.initState();
    // Tạo một đối tượng RoomsController
    roomsController = Get.find<RoomsController>();
    // Gọi hàm để lấy danh sách phòng
    roomsController.getAllRoom(widget.ownerID);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomsController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CircularProgressIndicator();
      } else {
        return Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.roomList.length,
            itemBuilder: (context, index) {
              // Hiển thị thông tin về từng phòng
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getRoomDetail(
                      controller.roomList[index].id!, "hotelDetail"));
                },
                child: Container(
                  //padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                      top: Dimensions.height20, bottom: Dimensions.height20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: controller.roomList[index].title!,
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
                                    color: Theme.of(context).disabledColor))),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "price".tr +
                                  _formatCurrency(
                                      controller.roomList[index].price!),
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: controller.roomList[index].desc!,
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
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      InkWell(
                        onTap: () {
                          bookRoomController.addRoomToSelection(
                              controller.roomList[index].id.toString(), "1");
                          Get.toNamed(RouteHelper.getBookRoomPage(
                              widget.placeID, "placeDetail"));
                        },
                        child: Container(
                          height: Dimensions.height10 * 5,
                          width: Dimensions.screenWidth,
                          decoration: BoxDecoration(
                              color: Colors.amber[600],
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10)),
                          child: Center(
                              child: BigText(
                            text: "Đặt ngay",
                            color: Colors.white,
                          )),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      )
                    ],
                  ),
                ),
              );
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
