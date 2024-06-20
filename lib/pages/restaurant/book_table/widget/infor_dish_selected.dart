import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
import 'package:flutter_babe/models/dish_model.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class InforDishSelected extends StatefulWidget {
  final int id;
  InforDishSelected({super.key, required this.id});

  @override
  State<InforDishSelected> createState() => _InforDishSelectedState();
}

class _InforDishSelectedState extends State<InforDishSelected> {
  late DishesController dishesController;
  Dish? dish;

  @override
  void initState() {
    super.initState();
    dishesController = Get.find<DishesController>();
    dishesController.getDishDetail(widget.id).then((value) {
      setState(() {
        dish = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookTableController>(
      builder: (bookTableController) {
        if (dish != null) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 211, 201, 201),
                  offset: const Offset(
                    1.5,
                    1.5,
                  ),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: dish!.title!,
                      color: Colors.lightBlue,
                    ),
                  ],
                ),
                // GestureDetector(
                //   onTap: () {
                //     _showDeleteConfirmationDialog(context, bookTableController);
                //   },
                //   child: Container(
                //     padding: EdgeInsets.all(5),
                //     child: FaIcon(
                //       FontAwesomeIcons.xmark,
                //       color: Colors.deepOrange,
                //     ),
                //   ),
                // )
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, BookTableController bookTableController) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('comfirm_delete'.tr)),
          content: Text('are_you_sure'.tr),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                bookTableController
                    .removeDishesFromSelection(widget.id.toString());
                Navigator.of(context).pop();
                setState(() {}); // Trigger a rebuild
              },
            ),
          ],
        );
      },
    );
  }
}
