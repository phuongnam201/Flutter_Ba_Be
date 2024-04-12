import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/pages/tour/widgets/gallery_image.dart';
import 'package:flutter_babe/pages/tour/widgets/highlight_tour.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/expandable_text_widget.dart';
import 'package:flutter_babe/widgets/icon_and_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';

class TourDetail extends StatefulWidget {
  int tourID;
  String pageID;
  TourDetail({
    Key? key,
    required this.tourID,
    required this.pageID,
  }) : super(key: key);

  @override
  State<TourDetail> createState() => _TourDetailState();
}

class _TourDetailState extends State<TourDetail> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var tour = Get.find<TourController>().getTourDetail(widget.tourID);
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return Scaffold(
        appBar: AppBar(
          title: Text("tour_detail".tr),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: Dimensions.screenWidth,
                    //margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radius20),
                          bottomRight: Radius.circular(Dimensions.radius20)),
                      image: DecorationImage(
                        image: NetworkImage(
                            AppConstants.BASE_URL + "storage/" + tour.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: tour.title!,
                            color: Colors.white,
                            size: Dimensions.font26,
                          ),
                          IconAndTextWidget(
                            text: tour.address!,
                            icon: Icons.location_on,
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            iconSize: Dimensions.iconSize16,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height45,
                    right: Dimensions.width20,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              print("You clicked on icon message");
                            },
                            child: Icon(
                              Icons.message_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          InkWell(
                            onTap: () {
                              print("you clicked on icon share");
                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          InkWell(
                            onTap: () {
                              print("you clicked on icon favorite");
                              setState(() {
                                // Khi nhấp vào, chuyển đổi trạng thái của biểu tượng
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color:
                                  isFavorite ? Colors.amber[700] : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height10,
                    right: Dimensions.width20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //origin price
                        Text(
                          "1.500.000 VNĐ",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.white),
                        ),
                        //sale price
                        //sale price
                        BigText(
                          text: tour.price.toString(),
                          color: Colors.amber[700],
                          size: Dimensions.font20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.height15,
              ),

              //gallery
              GalleryImage(
                tourID: widget.tourID,
                pageID: "tourDetail",
              ),
              Container(
                width: Dimensions.screenWidth,
                height: Dimensions.height10 * 4,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconAndTextWidget(
                        icon: Icons.timer_outlined,
                        text: tour.days.toString() + "ngày",
                        textColor: Colors.blue[800],
                        textSize: 15,
                        iconColor: Color.fromARGB(255, 21, 101, 192)),
                    IconAndTextWidget(
                        icon: Icons.train,
                        text: "Xe Khách",
                        textColor: Colors.blue[800],
                        textSize: 15,
                        iconColor: Color.fromARGB(255, 21, 101, 192))
                  ],
                ),
              ),

              Container(
                width: Dimensions.screenWidth,
                margin: EdgeInsets.all(Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "tour_detail".tr,
                      color: Colors.blue[800],
                      size: Dimensions.font20,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    HtmlWidget(
                      tour.content!,
                      textStyle: TextStyle(fontSize: Dimensions.font16),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(
                      text: "Chương trình tour",
                      color: Colors.blue[800],
                      size: Dimensions.font20,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    ExpandableTextWidget(
                        text: tour.desc!, showSeeLessOrMore: false),
                  ],
                ),
              ),
              //Feed back
              Container(
                width: Dimensions.screenWidth,
                margin: EdgeInsets.all(Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "feed_back".tr,
                      color: Colors.blue[800],
                      size: Dimensions.font20,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    feedBack()
                  ],
                ),
              ),
              Container(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(Dimensions.height20),
                      child: BigText(
                        text: "highlight_tour".tr,
                        color: Colors.blue[800],
                        size: Dimensions.font20,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: Dimensions.width10),
                        child: HighLightTour())
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              )
            ],
          ),
        ),
      );
    });
  }
}

Widget feedBack() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return Container(
    width: Dimensions.screenWidth,
    child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: Dimensions.screenWidth,
            height: 75,
            decoration: BoxDecoration(
              //color: Colors.amber,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // Màu sắc của đường border
                  width: 1.0, // Độ dày của đường border
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  margin: EdgeInsets.all(Dimensions.height10),
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 100,
                        child: BigText(
                          text: "Nguyen Phuong Nam",
                          maxLines: 1,
                          size: Dimensions.font16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.height10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 3, top: 2, right: 3, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.amber[600],
                            ),
                            child: Center(
                              child: SmallText(
                                text: "10",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          BigText(
                            text: "Tuyệt vời",
                            size: Dimensions.font16,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: Dimensions.width10 * 2,
                          ),
                          SmallText(text: formattedDate),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      Container(
                        //color: Colors.blue,
                        width: 200,
                        child: SmallText(
                          text:
                              "good good good very. That is the first time i have been there.",
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
  );
}
