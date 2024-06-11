import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
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
    //await Get.find<TourController>().getTourList();
  }

  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    scrollController.addListener(() {
      double showoffset = 10.0;

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return Scaffold(
          drawer: MenuSlider(),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: showbtn ? 1.0 : 0.0,
            child: FloatingActionButton(
              onPressed: () {
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              },
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _loadResource,
            child: NestedScrollView(
              controller: scrollController,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
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
                  floating: true,
                  snap: true,
                  title: Text("home".tr),
                  centerTitle: true,
                ),
              ],
              body: SingleChildScrollView(
                //controller: scrollController,
                child: BodyHomePage(),
              ),
            ),
          ),
        );
      },
    );
  }
}
