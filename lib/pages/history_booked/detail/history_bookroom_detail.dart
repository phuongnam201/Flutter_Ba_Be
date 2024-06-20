import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/history_book_room_controller.dart';
import 'package:flutter_babe/models/history_book_room_model.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';

class HistoryBookRoomDetail extends StatefulWidget {
  int bookRoomID;
  String pageID;
  HistoryBookRoomDetail(
      {super.key, required this.bookRoomID, required this.pageID});

  @override
  State<HistoryBookRoomDetail> createState() => _HistoryBookRoomDetailState();
}

class _HistoryBookRoomDetailState extends State<HistoryBookRoomDetail> {
  final HistoryBookRoomController historyBookRoomController =
      Get.find<HistoryBookRoomController>();

  HistoryBookRoomModel? historyBookRoomModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    historyBookRoomController
        .getDetailHistoryBookTable(widget.bookRoomID)
        .then((value) {
      historyBookRoomModel = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết đơn đặt phòng"),
        centerTitle: true,
        backgroundColor: AppColors.colorAppBar,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: BigText(text: "Hello"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
