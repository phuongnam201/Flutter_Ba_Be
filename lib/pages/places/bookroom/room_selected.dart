import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_room_controller.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/models/room_model.dart';
import 'package:flutter_babe/pages/places/bookroom/widget/infor_room_selected.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';

class RoomSelected extends StatefulWidget {
  const RoomSelected({super.key});

  @override
  State<RoomSelected> createState() => _RoomSelectedState();
}

class _RoomSelectedState extends State<RoomSelected> {
  final BookRoomController bookRoomController = Get.find<BookRoomController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookRoomController>(
      builder: (bookRoomController) {
        return Container(
          child: bookRoomController.roomsSelectedList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "Danh sách phòng bạn đã chọn: ",
                      color: AppColors.textColorBlue800,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    ListView.builder(
                      itemCount: bookRoomController.roomsSelectedList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final roomId =
                            bookRoomController.roomsSelectedList[index].roomId;
                        return GetBuilder<RoomsController>(
                          builder: (roomsController) {
                            final room = roomsController.roomList.firstWhere(
                              (room) => room.id.toString() == roomId,
                              orElse: () => Room(),
                            );
                            return room.id != null
                                ? InforRoomSelected(id: room.id!)
                                : SizedBox();
                          },
                        );
                      },
                    ),
                  ],
                )
              : SizedBox(),
        );
      },
    );
  }
}
