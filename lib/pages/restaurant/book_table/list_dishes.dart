import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListDishes extends StatefulWidget {
  int ownerID;
  String pageID;
  ListDishes({super.key, required this.ownerID, required this.pageID});

  @override
  State<ListDishes> createState() => _ListDishesState();
}

class _ListDishesState extends State<ListDishes> {
  final DishesController dishesController = Get.find<DishesController>();

  final BookTableController bookTableController =
      Get.find<BookTableController>();

  late List<bool> _checked;

  @override
  void initState() {
    super.initState();
    dishesController.getAllDishes(widget.ownerID);
    _checked = List<bool>.filled(dishesController.dishesList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DishesController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CustomLoader();
      } else {
        return Container(
          child: ListView.builder(
            itemCount: controller.dishesList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getDishDetail(
                      controller.dishesList[index].id!, "bookTablePage"));
                },
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  width: Dimensions.screenWidth,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[100]!),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimensions.height20 * 5,
                        width: Dimensions.width20 * 5,
                        // decoration: BoxDecoration(
                        //   borderRadius:
                        //       BorderRadius.circular(Dimensions.radius10),
                        //   image: DecorationImage(
                        //     image: NetworkImage(
                        //       AppConstants.BASE_URL +
                        //           "storage/" +
                        //           controller.dishesList[index].image!,
                        //     ),
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: AppConstants.BASE_URL +
                              "storage/" +
                              controller.dishesList[index].image!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius10,
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: Container(
                                width: 30,
                                height: 30,
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // SizedBox(
                      //   width: Dimensions.width10,
                      // ),
                      Container(
                        //color: AppColors.colorAppBar,
                        width: Dimensions.screenWidth * 0.5,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: controller.dishesList[index].title!,
                              maxLines: 2,
                              color: AppColors.textColorBlue800,
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            BigText(
                              text: 'price'.tr +
                                  _formatCurrency(dishesController
                                      .dishesList[index].price!),
                              color: Colors.lightBlue,
                              maxLines: 2,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                          ],
                        ),
                      ),
                      //Spacer(),
                      Container(
                        //color: Colors.red,
                        height: Dimensions.height10 * 3.5,
                        width: Dimensions.width10 * 3.5,
                        child: Checkbox(
                          value: _checked[index],
                          activeColor: AppColors.colorAppBar,
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              _checked[index] = value!;
                              if (value == true) {
                                bookTableController.addDishToSelection(
                                    controller.dishesList[index].id.toString());
                                Get.snackbar(
                                    "book_room".tr,
                                    "${controller.dishesList[index].title}" +
                                        " đã được thêm vào danh sách phòng đã chọn",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.black26);
                              } else {
                                bookTableController.removeDishesFromSelection(
                                    controller.dishesList[index].id.toString());
                                Get.snackbar(
                                    "book_room".tr,
                                    "${controller.dishesList[index].title}" +
                                        " đã bị xóa khỏi danh sách phòng đã chọn",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
