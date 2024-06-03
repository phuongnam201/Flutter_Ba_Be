import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/models/restaurant_model.dart';
import 'package:flutter_babe/pages/restaurant/widgets/dishes_widget.dart';
import 'package:flutter_babe/pages/restaurant/widgets/gallery_image.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RestaurantDetail extends StatefulWidget {
  int restaurantID;
  String pageID;
  RestaurantDetail({Key? key, required this.restaurantID, required this.pageID})
      : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final RestaurantController restaurantController =
      Get.find<RestaurantController>();

  Restaurant? restaurant;

  @override
  void initState() {
    super.initState();
    // Gọi hàm getRestaurantDetail khi widget được khởi tạo
    restaurantController
        .getRestaurantDetail(widget.restaurantID)
        .then((result) {
      setState(() {
        restaurant = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("restaurant_detail".tr),
      ),
      body: restaurant != null
          ? Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Dimensions.screenWidth * 0.65,
                              child: BigText(
                                text: restaurant!.title!,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.65,
                              child: SmallText(
                                  text: "address".tr +
                                      ": " +
                                      restaurant!.address!,
                                  size: Dimensions.font16),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(
                                    text: "share".tr + ": ",
                                    color: Colors.grey,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print(
                                          "you have just click on share on facebook");
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      // size: Dimensions.font16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.xTwitter,
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
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10)),
                          padding: EdgeInsets.only(
                              top: 10, left: 15, right: 15, bottom: 10),
                          child: Text(
                            "book_table".tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    GalleryImageRestaurant(
                        restaurantID: widget.restaurantID!,
                        pageID: widget.pageID),
                    HtmlWidget(restaurant!.content!),

                    //dish
                    DishesWidget(),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
