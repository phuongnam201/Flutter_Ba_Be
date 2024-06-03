import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:number_pagination/number_pagination.dart';

class OtherTourWidget extends StatefulWidget {
  const OtherTourWidget({super.key});

  @override
  State<OtherTourWidget> createState() => _OtherTourWidgetState();
}

class _OtherTourWidgetState extends State<OtherTourWidget> {
  late TouristAttractionController touristAttractionController;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   touristAttractionController = Get.find<TouristAttractionController>();
  // }

  @override
  Widget build(BuildContext context) {
    var selectedPageNumber = 1;
    return GetBuilder<TouristAttractionController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CircularProgressIndicator();
      } else {
        return Container(
          margin: EdgeInsets.only(top: Dimensions.height20),
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.screenWidth,
                child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: GridView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                    shrinkWrap:
                        true, // Wrap the GridView inside SingleChildScrollView
                    itemCount: 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 250,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        //height: 200, // Độ cao của container
                        width: double.infinity, // Chiều rộng mở rộng toàn bộ
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
                                    AppConstants.BASE_URL +
                                        "/storage/" +
                                        controller.touristAttractionOther[index]
                                            .image!,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: controller
                                        .touristAttractionOther[index].title!,
                                    color: Colors.blue[800],
                                    size: Dimensions.font16,
                                  ),
                                  Container(
                                    width: Dimensions.screenWidth * 0.35,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: Dimensions.font16,
                                          color:
                                              Theme.of(context).disabledColor,
                                        ),
                                        Container(
                                          width: Dimensions.screenWidth * 0.3,
                                          child: SmallText(
                                            text: controller
                                                .touristAttractionOther[index]
                                                .address!,
                                            maxLines: 1,
                                            color:
                                                Theme.of(context).disabledColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SmallText(
                                    text: controller
                                        .touristAttractionOther[index]
                                        .metaDescription!,
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
              ),
              NumberPagination(
                onPageChanged: (int pageNumber) {
                  setState(() {
                    // Gọi phương thức để chuyển đến trang mới
                    selectedPageNumber = pageNumber;
                    controller.getTourAttractListPGN(2, pageNumber);
                  });
                },
                threshold: 2,
                pageTotal: controller.touristAttractionOther.length,
                pageInit:
                    controller.currentPage, // picked number when init page
                colorPrimary: Colors.blue,
                colorSub: Colors.white,
              ),
            ],
          ),
        );
      }
    });
  }
}
