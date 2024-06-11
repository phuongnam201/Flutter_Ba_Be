import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/history_table_controller.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class HistoryBookTableWidget extends StatefulWidget {
  const HistoryBookTableWidget({super.key});

  @override
  State<HistoryBookTableWidget> createState() => _HistoryBookTableWidgetState();
}

class _HistoryBookTableWidgetState extends State<HistoryBookTableWidget> {
  final HistoryBookTableController historyBookTableController =
      Get.find<HistoryBookTableController>();

  @override
  void initState() {
    super.initState();
    historyBookTableController.getDataHistoryTable();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryBookTableController>(builder: (controller) {
      if (controller.isLoading) {
        return CustomLoader();
      } else {
        if (controller.historyBookTableList.isEmpty) {
          return Center(
            child: BigText(
              text: "Chưa có đơn đặt",
              color: Theme.of(context).disabledColor,
              size: Dimensions.font20,
            ),
          );
        } else {
          return Container(
            child: ListView.builder(
              itemCount: controller.historyBookTableList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      //color: Colors.amber,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      border:
                          Border.all(color: Theme.of(context).disabledColor)),
                  margin: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                      bottom: Dimensions.height10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(
                                text: "Mã đơn đặt: " +
                                    controller.historyBookTableList[index].id!
                                        .toString()),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "Tên khách đặt: " +
                                  controller.historyBookTableList[index].name!,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                                text: "Ngày đặt: " +
                                    controller
                                        .historyBookTableList[index].date!),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                                text: "Thời gian đặt: " +
                                    controller
                                        .historyBookTableList[index].time!),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                                text: "Số lượng bán: " +
                                    controller.historyBookTableList[index]
                                        .numberTable!
                                        .toString()),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                                text: "Số lượng người: " +
                                    controller
                                        .historyBookTableList[index].people!
                                        .toString()),
                          ],
                        ),
                        Container(
                          child: ElevatedButton(
                            child: SmallText(
                              text: "View detail",
                              color: Colors.white,
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[700],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
    });
  }
}
