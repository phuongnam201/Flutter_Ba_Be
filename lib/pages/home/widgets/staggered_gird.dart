// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class StaggeredScreen extends StatelessWidget {
  const StaggeredScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlacesController>(builder: (placesController) {
      return Container(
        margin: EdgeInsets.all(Dimensions.height10),
        child: StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(
            placesController.placesList.length,
            (index) => StaggeredGridTile.count(
              crossAxisCellCount:
                  (index == 0 || index == 5 || index == 8 || index == 13)
                      ? 2
                      : 1,
              mainAxisCellCount:
                  (index == 1 || index == 4 || index == 9 || index == 12)
                      ? 2
                      : 1,
              child: GestureDetector(
                onTap: () {
                  print("you just clicked on placesID: " +
                      placesController.placesList[index].id!.toString());
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(AppConstants.BASE_URL +
                              "storage/" +
                              placesController.placesList[index].image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black12, Colors.black54]),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0, // or any other position you want
                      right: 0, // or any other position you want
                      child: Container(
                        padding: EdgeInsets.all(
                            5.0), // Add padding to give space between text and edges
                        //color: Colors.black45, // Change color if needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              placesController.placesList[index].title!,
                              //textAlign: TextAlign., // Center align text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            // Text(
                            //   "Phone: " +
                            //       placesController.placesList[index].phone!,
                            //   //textAlign: TextAlign., // Center align text
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget getStaggeredGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_3.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_8.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_4.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_5.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_6.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/khachsan_7.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
