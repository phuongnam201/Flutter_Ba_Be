import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class NewsPageviewWiget extends StatelessWidget {
  const NewsPageviewWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: Dimensions.height10 * 35,
        margin: EdgeInsets.only(right: Dimensions.width10),
        child: ListView.builder(
          itemCount: controller.postList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getNewsDetailPage(
                    controller.postList[index].id!, "homePage"));
              },
              child: Container(
                color: AppColors.backgroundColor,
                width: Dimensions.screenWidth * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width10, right: Dimensions.width10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 1),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      height: Dimensions.height10 * 35,
                      width: Dimensions.screenWidth,
                      child: Column(
                        children: [
                          Container(
                            height: Dimensions.height10 * 25,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                              image: DecorationImage(
                                image: NetworkImage(AppConstants.BASE_URL +
                                    '/storage/' +
                                    controller.postList[index].image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(
                                  text: controller.postList[index].title!,
                                  size: Dimensions.font20,
                                  color: Colors.blue[700],
                                ),
                                SmallText(
                                  text: controller.postList[index].excerpt!,
                                  size: Dimensions.font20,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
