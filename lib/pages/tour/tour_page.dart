import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
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
  }
}


/** 
//highlight tour
Widget _buildHighLightTourView() {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius10)),
    height: 280,
    //width: Dimensions.screenWidth,
    margin: EdgeInsets.only(
        left: Dimensions.width10,
        //right: Dimensions.width10,
        top: Dimensions.height10),
    child: ListView.builder(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      //shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildHighLightTourItem(index);
      },
    ),
  );
}

Widget _buildHighLightTourItem(int index) {
  return Container(
    height: 280,
    width: 230,
    margin: EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius10),
      image: DecorationImage(
        image: AssetImage('assets/images/ho_ba_be.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          bottom: Dimensions.height10,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: "Hồ Ba Bể",
                  color: Colors.white,
                  size: Dimensions.font20,
                ),
                IconAndTextWidget(
                  text: "Lorem",
                  textColor: Colors.white,
                  icon: Icons.location_on,
                  iconSize: Dimensions.iconSize16,
                  iconColor: Colors.white,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                ElevatedButton(
                  onPressed: () {
                    print("You just clicked on book now with Tour ID: " +
                        index.toString());
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 255, 160, 0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                    ),
                  ),
                  child: Text("book_now".tr),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //origin price
              Text(
                "1.500.000 VNĐ",
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.white),
              ),
              //sale price
              BigText(
                text: "999.000 VNĐ",
                color: Colors.amber[700],
                size: Dimensions.font20,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

//normal tour
Widget _buildTourView() {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius10)),
    //height: Dimensions.screenHeight,
    width: Dimensions.screenWidth,
    margin: EdgeInsets.only(
        left: Dimensions.width20,
        right: Dimensions.width20,
        top: Dimensions.height10),
    child: ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.vertical,
      shrinkWrap: true, // Set shrinkWrap to true
      itemBuilder: (context, index) {
        return _buildTourItem(index);
      },
    ),
  );
}

Widget _buildTourItem(int index) {
  return Container(
    width: Dimensions.screenWidth,
    height: Dimensions.height10 * 13,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius20)),
    margin: EdgeInsets.only(
      bottom: Dimensions.height10,
    ),
    child: Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          //image
          Container(
            //height: 100,
            width: 90,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://vrbabe.kennatech.vn//storage/places/March2024/xiqgtXAkSSQUP5524SPS.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius10)),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          //information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Dimensions.screenWidth * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconAndTextWidget(
                        icon: Icons.location_on,
                        text: "Lorem",
                        textColor: Colors.lightBlue,
                        iconColor: Colors.lightBlue),
                    BigText(
                      text: "Lorem",
                      size: Dimensions.font16,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Container(
                //color: Colors.amber,
                width: Dimensions.screenWidth * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //origin price
                        Text(
                          "1.500.000 VNĐ",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                        //sale price
                        BigText(
                          text: "999.000 VNĐ",
                          color: Colors.amber[700],
                          size: Dimensions.font20,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print("You just clicked on book now with Tour ID: " +
                            index.toString());
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 160, 0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                        ),
                      ),
                      child: Text("book_now".tr),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
*/