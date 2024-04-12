import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/pages/home/body_home_page.dart';
import 'package:flutter_babe/pages/menuSlider/menu_slider.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadResource() async {
    await Get.find<TourController>().getTourList();
  }

  @override
  Widget build(BuildContext context) {
    //height of screen
    print("current height: " + MediaQuery.of(context).size.height.toString());
    //witdh
    print("current width: " + MediaQuery.of(context).size.width.toString());

    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return Scaffold(
        drawer: MenuSlider(),
        appBar: AppBar(
          title: Text("home".tr),
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(RouteHelper.getNotificationPage());
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
            child: Column(
              children: [
                //showing the body
                Expanded(
                  child: SingleChildScrollView(
                    child: BodyHomePage(),
                  ),
                )
              ],
            ),
            onRefresh: _loadResource),
      );
    });
  }
}
