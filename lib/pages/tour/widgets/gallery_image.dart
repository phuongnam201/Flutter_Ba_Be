// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/utils/dimension.dart';

class GalleryImage extends StatefulWidget {
  int tourID;
  String pageID;
  GalleryImage({
    Key? key,
    required this.tourID,
    required this.pageID,
  }) : super(key: key);

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

int selectedImageIndex = 0;

class _GalleryImageState extends State<GalleryImage> {
  @override
  Widget build(BuildContext context) {
    List<String> images =
        Get.find<TourController>().getImageList(widget.tourID);

    print(images);
    return Container(
      width: Dimensions.screenWidth,
      margin: EdgeInsets.all(Dimensions.height20),
      child: Container(
        //color: Colors.red,
        width: Dimensions.screenWidth,
        child: Column(
          children: [
            Container(
              height: 200,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                image: selectedImageIndex < images.length
                    ? DecorationImage(
                        image: NetworkImage(AppConstants.BASE_URL +
                            "storage/" +
                            images[selectedImageIndex]),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              // Adjust the height of the large image container
            ),
            SizedBox(
              height: Dimensions.height10 / 3,
            ),
            Container(
              // color: Colors.amber,
              height: 60, // Adjust the height of the thumbnail images container
              child: ListView.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImageIndex = index;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Image.network(
                          AppConstants.BASE_URL + "storage/" + images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
