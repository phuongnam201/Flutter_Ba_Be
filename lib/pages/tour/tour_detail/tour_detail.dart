import 'package:flutter/material.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/pages/tour/widgets/gallery_image.dart';
import 'package:flutter_babe/pages/tour/widgets/highlight_tour.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
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
  final TourController tourController = Get.find<TourController>();
  Tour? tour;
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tourController.getTourDetail(widget.tourID!).then((value) {
      setState(() {
        tour = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("tour_detail".tr),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: tour != null
            ? SingleChildScrollView(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Dimensions.screenWidth * 0.65,
                                child: BigText(
                                    text: tour!.title!,
                                    color: Colors.blue[800]),
                              ),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              Container(
                                width: Dimensions.screenWidth * 0.65,
                                child: SmallText(
                                    text: "address".tr + ": " + tour!.address!,
                                    size: Dimensions.font16),
                              ),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              //share social button
                              Container(
                                width: Dimensions.screenWidth * 0.6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                      text: "share".tr + ": ",
                                      color: Colors.grey,
                                      size: Dimensions.font20,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.facebook,
                                      // size: Dimensions.font16,
                                      color: Colors.blue,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.xTwitter,
                                      // size: Dimensions.font16,
                                      //color: Colors.,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.linkedin,
                                      // size: Dimensions.font16,
                                      color: Colors.red,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.googlePlus,
                                      // size: Dimensions.font16,
                                      color: Color(0xFF4285F4),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print("you have just clicked on button");
                            },
                            child: Container(
                              width: Dimensions.screenWidth * 0.2,
                              decoration: BoxDecoration(
                                  color: Colors.amber[600],
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius10)),
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: Center(
                                child: Text(
                                  "Liên hệ tư vấn",
                                  //maxLines: 2,
                                  //textAlign: TextAlign.justify,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
                              text: tour!.days.toString() + "ngày",
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
                            tour!.content!,
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
                          SmallText(
                            text: tour!.desc!,
                            size: Dimensions.font16,
                            color: Colors.black87,
                          ),
                          // ExpandableTextWidget(
                          //     text: tour!.desc!, showSeeLessOrMore: false),
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
              )
            : CustomLoader());
  }
}

//commnet fake
Widget feedBack() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return Container(
    width: Dimensions.screenWidth,
    child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: Dimensions.screenWidth,
            height: Dimensions.height10 * 8,
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
                            width: Dimensions.width10 * 3.5,
                          ),
                          SmallText(text: formattedDate),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      Container(
                        //color: Colors.blue,
                        width: Dimensions.width10 * 20,
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
