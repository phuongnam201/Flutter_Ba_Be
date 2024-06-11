import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FoodInBookTable extends StatefulWidget {
  final int owner_id;
  FoodInBookTable({super.key, required this.owner_id});

  @override
  State<FoodInBookTable> createState() => _FoodInBookTableState();
}

class _FoodInBookTableState extends State<FoodInBookTable> {
  final BookTableController bookTableController =
      Get.find<BookTableController>();

  late DishesController dishesController;

  @override
  void initState() {
    super.initState();
    dishesController = Get.find<DishesController>();
    dishesController.getAllDishes(widget.owner_id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DishesController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CircularProgressIndicator();
      } else {
        return Container(
          child: ListView.builder(
            itemCount: controller.dishesList.length,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getRoomDetail(
                          controller.dishesList[index].id!, "hotelDetail"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: controller.dishesList[index].title!,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Image.network(
                            AppConstants.BASE_URL +
                                "/storage/" +
                                controller.dishesList[index].image!,
                            height: Dimensions.height100 * 3,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Theme.of(context).disabledColor))),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: 'price'.tr +
                                      _formatCurrency(
                                          controller.dishesList[index].price!),
                                  color: Colors.lightBlue,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                SmallText(
                                  text: controller.dishesList[index].desc!,
                                  color: Colors.blue[800],
                                  size: Dimensions.font16,
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  InkWell(
                    onTap: () {
                      bookTableController.addDishToSelection(
                          controller.dishesList[index].id.toString());
                      print("You have just clicked on select this");
                    },
                    child: Container(
                      height: Dimensions.height10 * 5,
                      width: Dimensions.screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.amber[700],
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10)),
                      child: Center(
                          child: SmallText(
                        text: "select".tr,
                        color: Colors.white,
                        size: Dimensions.font20,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  )
                ],
              ));
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
