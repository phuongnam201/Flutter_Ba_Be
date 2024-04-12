import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/pages/home/widgets/restaurant_pageview_widget.dart';
import 'package:flutter_babe/pages/home/widgets/tour_pageview_widget.dart';
import 'package:flutter_babe/pages/home/widgets/tourist_attraction_widget.dart';
import 'package:flutter_babe/pages/news/widgets/news_widget.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:flutter_babe/pages/home/widgets/staggered_gird.dart';
import 'package:get/get.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TourController>(builder: (tourController) {
      return GetBuilder<TouristAttractionController>(
          builder: (touristAttractionController) {
        return GetBuilder<RestaurantController>(
            builder: (restaurantController) {
          return Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/banner.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: Dimensions.height30),
              _buildSection("Tour du lịch được quan tâm nhiều nhất",
                  "Nhanh tay đặt ngay. Để mai sẽ lỡ"),
              SizedBox(height: Dimensions.height10),
              TourPageview(tourList: tourController.tourList),
              SizedBox(height: Dimensions.height30),
              _buildSection("Địa điểm du lịch hấp dẫn",
                  "Thư giãn - Nạp năng lượng - Khám phá mới"),
              SizedBox(height: Dimensions.height10),
              TouristAttractionPageview(
                touristAttractionList:
                    touristAttractionController.touristAttractionList,
              ),
              SizedBox(height: Dimensions.height30),
              _buildSection("Cơ sở lưu trú", "Tận hưởng khoảnh khắc thư giãn"),
              SizedBox(height: Dimensions.height10),
              StaggeredScreen(),
              SizedBox(height: Dimensions.height30),
              _buildSection(
                  "Khám phá ẩm thực", "Vô vàn món ăn ngon và hấp dẫn"),
              SizedBox(height: Dimensions.height10),
              RestaurantPageview(
                restaurantList: restaurantController.restaurantList,
              ),
              SizedBox(height: Dimensions.height30),
              _buildSection("Tin tức bài viết", ""),
              _buildNewsPage(),
              SizedBox(height: Dimensions.height10),
              //SizedBox(height: Dimensions.height30),
            ],
          );
        });
      });
    });
  }

  Widget _buildSection(String bigText, String smallText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10),
          child: BigText(text: bigText),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10),
          child: SmallText(text: smallText, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildNewsPage() {
    return Container(
      height: 350,
      margin: EdgeInsets.only(right: Dimensions.width10),
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return NewsWidget();
        },
      ),
    );
  }

  Widget _buildPageView(List<Tour> tour) {
    return Container(
      height: 300,
      margin:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: ListView.builder(
        itemCount: tour.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return _buildPageItem(index);
        },
      ),
    );
  }

  Widget _buildPageItem(int index) {
    return Container(
      height: 312,
      width: 243,
      margin: EdgeInsets.only(left: 5, right: 5),
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
            bottom: Dimensions.height45,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "Hồ Ba Bể",
                    color: Colors.white,
                    size: Dimensions.font26,
                  ),
                  SmallText(
                    text: "Lorem",
                    size: Dimensions.font16,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
