import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/models/tourist_attraction_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height10 * 31,
      margin: EdgeInsets.only(left: Dimensions.width10),
      child: ListView.builder(
        itemCount: widget.touristAttractionList.length >= 8
            ? 9
            : widget.touristAttractionList.length +
                1, // Thêm một phần tử cho nút "See more"
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          if (index == 8 || index == widget.touristAttractionList.length) {
            return _buildSeeMoreButton();
          } else {
            return _buildPageItem(widget.touristAttractionList[index]);
          }
        },
      ),
    );
  }

  Widget _buildSeeMoreButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: Dimensions.height10 * 30, // chiều cao tương tự như các mục khác
        width: Dimensions.width10 * 26, // chiều rộng tương tự như các mục khác
        margin: EdgeInsets.only(right: Dimensions.width10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.radius10,
          ),
          color: Colors.grey[200],
        ),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(RouteHelper.getTouristAttractionPage());
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.colorButton!),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
            ),
          ),
          child: Text(
            "see_more".tr,
          ),
        ),
      ),
    );
  }

  Widget _buildPageItem(TouristAttraction touristAttraction) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getTouristAttractionDetailPage(
            touristAttraction.id!, "homePage"));
      },
      child: Container(
        height: Dimensions.height10 * 31,
        width: Dimensions.width10 * 26,
        margin: EdgeInsets.only(right: Dimensions.width10),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  AppConstants.BASE_URL + "storage/" + touristAttraction.image!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius10,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: Container(
                    width: 30,
                    height: 30,
                    child: Center(child: CircularProgressIndicator())),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Positioned(
              bottom: Dimensions.height45,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                width: Dimensions.screenWidth * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black12, Colors.black54],
                        ),
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
          ],
        ),
      ),
    );
  }
}
