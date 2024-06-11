import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/models/tourist_attraction_model.dart';
import 'package:flutter_babe/pages/tourist_attraction/widgets/other_tour.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
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
  final TouristAttractionController touristAttractionController =
      Get.find<TouristAttractionController>();
  TouristAttraction? touristAttraction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    touristAttractionController
        .getTourDetail(widget.tourAttractionID!)
        .then((value) {
      setState(() {
        touristAttraction = value;
      });
    });
  }

  var selectedPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tourist_attraction_detail".tr),
        centerTitle: true,
      ),
      body: touristAttraction != null
          ? SingleChildScrollView(
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
                              bottomRight:
                                  Radius.circular(Dimensions.radius20)),
                          image: DecorationImage(
                            image: NetworkImage(AppConstants.BASE_URL +
                                "storage/" +
                                touristAttraction!.image!),
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
                                text: touristAttraction!.title!,
                                color: Colors.white,
                                size: Dimensions.font26,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: Dimensions.font16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Container(
                                    width: Dimensions.screenWidth * 0.8,
                                    child: SmallText(
                                      text: touristAttraction!.address!,
                                      color: Colors.white,
                                      size: Dimensions.font16,
                                    ),
                                  )
                                ],
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
                          text: touristAttraction!.title!,
                          color: Colors.blue[800],
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        HtmlWidget(
                          touristAttraction!.content!,
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
                        //other touristAttraction
                        OtherTourWidget(),
                      ],
                    ),
                  )
                ],
              ),
            )
          : CustomLoader(),
    );
  }
}
