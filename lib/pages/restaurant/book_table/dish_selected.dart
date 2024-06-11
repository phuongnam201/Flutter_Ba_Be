import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/models/book_table_model.dart';
import 'package:flutter_babe/pages/restaurant/book_table/widget/infor_dish_selected.dart';
import 'package:get/get.dart';

class DishSelected extends StatefulWidget {
  const DishSelected({super.key});

  @override
  State<DishSelected> createState() => _DishSelectedState();
}

class _DishSelectedState extends State<DishSelected> {
  final BookTableController bookTableController =
      Get.find<BookTableController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookTableController>(
      builder: (bookTableController) {
        return Container(
          child: bookTableController.dishesSelectedList.isNotEmpty
              ? ListView.builder(
                  itemCount: bookTableController.dishesSelectedList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final dishId =
                        bookTableController.dishesSelectedList[index].dishId;
                    return GetBuilder<RoomsController>(
                      builder: (roomsController) {
                        final dish =
                            bookTableController.dishesSelectedList.firstWhere(
                          (dish) => dish.dishId == dishId,
                          orElse: () => DishesSelected(),
                        );
                        return dish.dishId != null
                            ? InforDishSelected(id: int.parse(dish.dishId!))
                            : SizedBox();
                      },
                    );
                  },
                )
              : SizedBox(),
        );
      },
    );
  }
}
