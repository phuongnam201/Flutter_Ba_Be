// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/icon_and_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class TouristAttractionDetailPage extends StatefulWidget {
  int tourAttractionID;
  String pageID;
  TouristAttractionDetailPage({
    Key? key,
    required this.tourAttractionID,
    required this.pageID,
  }) : super(key: key);

  @override
  State<TouristAttractionDetailPage> createState() =>
      _TouristAttractionDetailPageState();
}

class _TouristAttractionDetailPageState
    extends State<TouristAttractionDetailPage> {
  @override
  Widget build(BuildContext context) {
    var tour = Get.find<TouristAttractionController>()
        .getTouristAttraction(widget.tourAttractionID);
    return Scaffold(
      appBar: AppBar(
        title: Text("tourist_attraction_detail".tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Dimensions.height200,
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
                          icon: Icons.location_on,
                          text: "lorem",
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          iconSize: Dimensions.iconSize16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(Dimensions.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "Đôi nét về " + tour.title!,
                    color: Colors.blue[800],
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  HtmlWidget(
                    tour.content!,
                  ),
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.all(Dimensions.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    padding: EdgeInsets.only(bottom: Dimensions.font20),
                    child: BigText(
                      text: "Điểm du lịch khác",
                      color: Colors.blue[800],
                    ),
                  ),
                  Container(
                    height: Dimensions.height100 * 3,
                    width: Dimensions.screenWidth,
                    color: Colors.grey[300],
                    child: Container(
                      margin: EdgeInsets.all(Dimensions.height20),
                      child: GridView.builder(
                        physics:
                            NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                        shrinkWrap:
                            true, // Wrap the GridView inside SingleChildScrollView
                        itemCount: 2,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 250,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            //height: 200, // Độ cao của container
                            width:
                                double.infinity, // Chiều rộng mở rộng toàn bộ
                            // Padding cho container
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
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    //borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: Dimensions.height10),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  width: Dimensions.screenWidth * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: "Lorem",
                                        color: Colors.blue[800],
                                        size: Dimensions.font16,
                                      ),
                                      IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: "Lorem",
                                          textSize: Dimensions.font16 - 6,
                                          iconSize: Dimensions.font16 - 6,
                                          textColor: Colors.grey,
                                          iconColor: Colors.grey),
                                      SmallText(
                                        text:
                                            "Làm sao ta có thể nhìn thấy vĩnh hằng trong một hạt cát, hay tìm thấy vô biên trong một đóa hoa? Không gì trên thế giới này là hoàn hảo, nhưng mỗi chúng ta lại mang trong mình vẻ đẹp đặc biệt, giống như những viên ngọc quý ẩn giấu trong bụi rậm của cuộc sống.",
                                        maxLines: 3,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
