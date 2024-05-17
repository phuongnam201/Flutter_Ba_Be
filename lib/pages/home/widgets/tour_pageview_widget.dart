import 'package:flutter/material.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class TourPageview extends StatefulWidget {
  final List<Tour> tourList;

  const TourPageview({
    Key? key,
    required this.tourList,
  }) : super(key: key);

  @override
  State<TourPageview> createState() => _TourPageviewState();
}

class _TourPageviewState extends State<TourPageview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height10 * 31,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.tourList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return _buildPageItem(widget.tourList[index]);
        },
      ),
    );
  }
}

Widget _buildPageItem(Tour tour) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(RouteHelper.getTourDetailPage(tour.id!, "homePage"));
    },
    child: Container(
      height: Dimensions.height10 * 30, // theo thiet ke se la 312
      width: Dimensions.width10 * 26, //243
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        image: DecorationImage(
          image: tour.image != null
              ? NetworkImage(
                  '${AppConstants.BASE_URL}storage/${tour.imageMoblie}')
              : AssetImage('assets/images/ho_ba_be.jpg') as ImageProvider,
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: Dimensions.height45,
            left: 0,
            child: Container(
              width: Dimensions.screenWidth * 0.6,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: tour.title ?? "",
                    color: Colors.white,
                    size: Dimensions.font26,
                    maxLines: 1,
                  ),
                  SmallText(
                    text: tour.desc ?? "",
                    size: Dimensions.font16,
                    color: Colors.white,
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
