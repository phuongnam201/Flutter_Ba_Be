import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_babe/models/tourist_attraction_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class TouristAttractionPageview extends StatefulWidget {
  final List<TouristAttraction> touristAttractionList;

  const TouristAttractionPageview({
    Key? key,
    required this.touristAttractionList,
  }) : super(key: key);

  @override
  State<TouristAttractionPageview> createState() =>
      _TouristAttractionPageviewState();
}

class _TouristAttractionPageviewState extends State<TouristAttractionPageview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
      child: ListView.builder(
        itemCount: widget.touristAttractionList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return _buildPageItem(widget.touristAttractionList[index]);
        },
      ),
    );
  }
}

Widget _buildPageItem(TouristAttraction touristAttraction) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(RouteHelper.getTouristAttractionDetailPage(
          touristAttraction.id!, "homePage"));
    },
    child: Container(
      height: 312,
      width: 243,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        image: DecorationImage(
          image: touristAttraction.image != null
              ? NetworkImage(
                  '${AppConstants.BASE_URL}storage/${touristAttraction.image}')
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
              padding: EdgeInsets.all(8),
              child: Container(
                width: Dimensions.screenWidth * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black12, Colors.black54]),
                      ),
                    ),
                    BigText(
                      text: touristAttraction.title ?? "",
                      color: Colors.white,
                      size: Dimensions.font26,
                      maxLines: 1,
                    ),
                    SmallText(
                      text: touristAttraction.desc ?? "",
                      size: Dimensions.font16,
                      color: Colors.white,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
