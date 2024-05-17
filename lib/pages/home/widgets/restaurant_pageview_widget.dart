import 'package:flutter/material.dart';
import 'package:flutter_babe/models/restaurant_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';

class RestaurantPageview extends StatefulWidget {
  final List<Restaurant> restaurantList;

  const RestaurantPageview({
    Key? key,
    required this.restaurantList,
  }) : super(key: key);

  @override
  State<RestaurantPageview> createState() => _RestaurantPageviewState();
}

class _RestaurantPageviewState extends State<RestaurantPageview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height10 * 31,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      child: ListView.builder(
        itemCount: widget.restaurantList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return _buildPageItem(widget.restaurantList[index]);
        },
      ),
    );
  }
}

Widget _buildPageItem(Restaurant restaurantList) {
  return Container(
    height: Dimensions.height10 * 31,
    width: Dimensions.width10 * 26,
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius10),
      image: DecorationImage(
        image: restaurantList.image != null
            ? NetworkImage(
                '${AppConstants.BASE_URL}storage/${restaurantList.image}')
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
                  text: restaurantList.title ?? "",
                  color: Colors.white,
                  size: Dimensions.font26,
                  maxLines: 1,
                ),
                SmallText(
                  text: restaurantList.desc ?? "",
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
  );
}
