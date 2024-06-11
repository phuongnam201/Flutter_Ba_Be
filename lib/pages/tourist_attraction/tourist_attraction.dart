import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:number_pagination/number_pagination.dart';

class TouristAttractionPage extends StatefulWidget {
  const TouristAttractionPage({super.key});

  @override
  State<TouristAttractionPage> createState() => _TouristAttractionPageState();
}

class _TouristAttractionPageState extends State<TouristAttractionPage> {
  PageController pageController = PageController(viewportFraction: 0.95);
  var _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        //print("curr value" + _currentPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TouristAttractionController>(builder: (controller) {
      var selectedPageNumber = 1;
      return Scaffold(
        appBar: AppBar(
          title: Text("tourist_attraction".tr),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //height: 250,
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PictureWidget(pageController, _currentPageValue),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: BigText(
                            text: "Điểm du lịch nổi bật",
                            color: Colors.blue[800],
                          )),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                    ]),
              ),
              Container(
                // height: Dimensions.screenHeight,
                margin: EdgeInsets.all(Dimensions.height20),
                width: Dimensions.screenWidth,
                child: GridView.builder(
                  physics:
                      NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                  shrinkWrap:
                      true, // Wrap the GridView inside SingleChildScrollView
                  itemCount: controller.touristAttractionList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 250,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getTouristAttractionDetailPage(
                            controller.touristAttractionList[index].id!,
                            "TourAttractionPage"));
                      },
                      child: Container(
                        //height: 200, // Độ cao của container
                        //width: double.infinity, // Chiều rộng mở rộng toàn bộ
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
                              height: Dimensions.height10 * 15,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    AppConstants.BASE_URL +
                                        "storage/" +
                                        controller.touristAttractionList[index]
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
                                        .touristAttractionList[index].title!,
                                    color: Colors.blue[800],
                                    size: Dimensions.font16,
                                  ),
                                  Container(
                                    width: Dimensions.screenWidth * 0.4,
                                    child: Row(children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: Dimensions.font16 - 2,
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10 / 5,
                                      ),
                                      Container(
                                          width: Dimensions.screenWidth * 0.30,
                                          child: SmallText(
                                            text: controller
                                                .touristAttractionList[index]
                                                .address!,
                                            maxLines: 1,
                                          )),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10 / 2,
                                  ),
                                  SmallText(
                                    text: controller
                                        .touristAttractionList[index]
                                        .metaDescription!,
                                    maxLines: 3,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              NumberPagination(
                onPageChanged: (int pageNumber) {
                  setState(() {
                    // Gọi phương thức để chuyển đến trang mới
                    selectedPageNumber = pageNumber;
                    controller.getTouristAttractionList(8, pageNumber);
                  });
                },
                threshold: 2,
                pageTotal: (controller.touristAttractionList.length / 8).ceil(),
                pageInit:
                    controller.currentPage, // picked number when init page
                colorPrimary: Colors.blue,
                colorSub: Colors.white,
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget PictureWidget(PageController pageController, var _currentPageValue) {
  return Container(
    height: 200,
    child: Stack(
      children: [
        Container(
          //padding: EdgeInsets.all(10),
          height: 200,
          width: Dimensions.screenWidth,
          margin: EdgeInsets.only(
              top: Dimensions.height20, left: Dimensions.width20),
          child: PageView.builder(
            itemCount: 5,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            padEnds: false,
            itemBuilder: (context, index) {
              return _buildPageItem(index);
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsIndicator(
                dotsCount: 5,
                position: _currentPageValue,
                decorator: const DotsDecorator(
                  color: Colors.white, // Inactive color
                  activeColor: Colors.amber,
                  size: Size.square(6.0),
                  activeSize: Size(15.0, 6.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPageItem(int index) {
  return GestureDetector(
    onTap: () {
      // Get.toNamed(RouteHelper.getTouristAttractionDetailPage());
    },
    child: Container(
      height: 200,
      width: Dimensions.screenWidth,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        image: DecorationImage(
          image: AssetImage('assets/images/ho_ba_be.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: Dimensions.height20,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 20, top: 2, right: 20, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[600],
                    ),
                    child: Center(
                        child: BigText(
                      text: "New",
                      color: Colors.white,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: "Hồ Ba Bể",
                    color: Colors.white,
                    size: Dimensions.font20,
                  ),
                  SmallText(
                    text: "Lorem",
                    size: Dimensions.font16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Row(
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
                    ))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
