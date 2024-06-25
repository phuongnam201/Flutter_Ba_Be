import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/history_book_room_controller.dart';
import 'package:flutter_babe/models/history_book_room_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      setState(() {
        historyBookRoomModel = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryBookRoomController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text("booking_detail".tr),
          centerTitle: true,
          backgroundColor: AppColors.colorAppBar,
        ),
        body: historyBookRoomModel != null
            ? SingleChildScrollView(
                child: Container(
                  //height: Dimensions.screenHeight,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "booking_information".tr),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "fullname".tr +
                                  ": " +
                                  historyBookRoomModel!.name!,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "phone".tr +
                                  ": " +
                                  historyBookRoomModel!.phone!.toString(),
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "adults".tr +
                                  ": " +
                                  historyBookRoomModel!.adults!.toString(),
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "children".tr +
                                  ": " +
                                  historyBookRoomModel!.children!.toString(),
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              children: [
                                SmallText(
                                  text: "accommodation_facility".tr + ": ",
                                  size: Dimensions.font16,
                                ),
                                SmallText(
                                  text: historyBookRoomModel!.namePlace != null
                                      ? controller
                                          .historyBookRoomModel!.namePlace!
                                      : "updating".tr,
                                  size: Dimensions.font16,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "check_in".tr +
                                  ": " +
                                  historyBookRoomModel!.checkin!,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "check_out".tr +
                                  ": " +
                                  historyBookRoomModel!.checkout!,
                              size: Dimensions.font16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      BigText(text: "list_of_booked_rooms".tr),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      ListView.builder(
                        itemCount: controller.roomsListInBookedList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getRoomDetail(
                                  controller.roomsListInBookedList[index].id!,
                                  "historyBookRoom"));
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height10),
                              height: Dimensions.height20 * 7,
                              width: Dimensions.screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: Dimensions.height20 * 7,
                                    width: Dimensions.width20 * 6,
                                    child: CachedNetworkImage(
                                      imageUrl: AppConstants.BASE_URL +
                                          "storage/" +
                                          controller
                                              .roomsListInBookedList[index]
                                              .image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Dimensions.radius10,
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Center(
                                        child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator())),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Container(
                                    width: Dimensions.screenWidth * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: controller
                                              .roomsListInBookedList[index]
                                              .title!,
                                          color: AppColors.colorAppBar,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        SmallText(
                                          text: "price".tr +
                                              _formatCurrency(controller
                                                  .roomsListInBookedList[index]
                                                  .price!),
                                          size: Dimensions.font16,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        SmallText(
                                          text: controller
                                              .roomsListInBookedList[index]
                                              .desc!
                                              .toString(),
                                          size: Dimensions.font16,
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        SmallText(
                                          text: "number_of_rooms".tr +
                                              controller
                                                  .pivotList[index].number!
                                                  .toString(),
                                          size: Dimensions.font16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : CustomLoader(),
      );
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
