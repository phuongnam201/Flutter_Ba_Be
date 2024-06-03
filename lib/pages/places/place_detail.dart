import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/models/places_model.dart';
import 'package:flutter_babe/pages/places/widget/gallery_places.dart';
import 'package:flutter_babe/pages/places/widget/other_hotel_widget.dart';
import 'package:flutter_babe/pages/places/widget/room_widget.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PlaceDetail extends StatefulWidget {
  int placeID;
  String pageID;
  PlaceDetail({Key? key, required this.placeID, required this.pageID})
      : super(key: key);

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  final PlacesController placesController = Get.find<PlacesController>();

  Places? places;

  @override
  void initState() {
    super.initState();
    // Gọi hàm getRestaurantDetail khi widget được khởi tạo
    placesController.getPlaceDetail(widget.placeID).then((result) {
      setState(() {
        places = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("accommodation_facility_detail".tr),
      ),
      body: places != null
          ? Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //hotel detail
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Dimensions.screenWidth * 0.65,
                              child: BigText(
                                  text: places!.title!,
                                  color: Colors.blue[800]),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.65,
                              child: SmallText(
                                  text: "address".tr + ": " + places!.address!,
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
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.amber[600],
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10)),
                          padding: EdgeInsets.only(
                              top: 10, left: 15, right: 15, bottom: 10),
                          child: Text(
                            "book_room".tr,
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
                    GalleryImagePlace(
                        placeID: widget.placeID!, pageID: widget.pageID),
                    HtmlWidget(places!.content!),

                    //room
                    RoomWidget(),

                    //other hotel
                    OtherHotelWidget()
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void depose() {
    print("call depose at place detail");
    super.dispose();
  }
}
