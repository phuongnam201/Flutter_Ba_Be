import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/pages/tour/widgets/highlight_tour.dart';
import 'package:flutter_babe/pages/tour/widgets/normal_tour.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:get/get.dart';

class TourPage extends StatelessWidget {
  const TourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetBuilder<TourController>(builder: (tourController) {
        return Scaffold(
          appBar: AppBar(
            title: Text("tour".tr),
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: Dimensions.screenWidth * 0.9,
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.white,
                              Color.fromARGB(255, 238, 238, 238)
                            ],
                          ),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20)),
                      //child: Text(""),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20, left: Dimensions.width20),
                      child: HighLightTour(),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //_buildTourView()
                //normal tour
                NormalTour(),
              ],
            ),
          ),
        );
      });
    });
  }
}
