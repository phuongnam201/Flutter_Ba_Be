import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_room_controller.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/models/room_model.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class InforRoomSelected extends StatefulWidget {
  final int id;
  InforRoomSelected({super.key, required this.id});

  @override
  State<InforRoomSelected> createState() => _InforRoomSelectedState();
}

class _InforRoomSelectedState extends State<InforRoomSelected> {
  late RoomsController roomsController;
  Room? room;

  @override
  void initState() {
    super.initState();
    roomsController = Get.find<RoomsController>();
    roomsController.getRoomDetail(widget.id).then((value) {
      setState(() {
        room = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookRoomController>(
      builder: (bookRoomController) {
        String? roomSelected =
            bookRoomController.getRoomNumberById(widget.id.toString());

        if (room != null) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 211, 201, 201),
                  offset: const Offset(
                    1.5,
                    1.5,
                  ),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: room!.title!,
                      color: Colors.lightBlue,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    if (roomSelected != null)
                      SmallText(
                        text: roomSelected + " " + "room".tr,
                        size: Dimensions.font16,
                        color: Colors.black87,
                      )
                    else
                      SmallText(text: "No rooms selected")
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _showDeleteConfirmationDialog(context, bookRoomController);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.deepOrange,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, BookRoomController bookRoomController) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('comfirm_delete'.tr)),
          content: Text('are_you_sure'.tr),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                bookRoomController
                    .removeRoomFromSelection(widget.id.toString());
                Navigator.of(context).pop();
                setState(() {}); // Trigger a rebuild
              },
            ),
          ],
        );
      },
    );
  }
}
