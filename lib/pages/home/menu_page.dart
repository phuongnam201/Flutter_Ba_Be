import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/pages/home/home_page.dart';
import 'package:flutter_babe/pages/search/search_page.dart';
import 'package:flutter_babe/pages/test_callController/test_page.dart';
import 'package:flutter_babe/pages/tour/tour_page.dart';
import 'package:flutter_babe/pages/tourist_attraction/tourist_attraction.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MenuPage extends StatelessWidget {
  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> pages() {
    return [
      HomePage(),
      TourPage(),
      TouristAttractionPage(),
      SearchPage(),
      TestPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(
      BuildContext context, LocalizationController controller) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "home".tr,
        inactiveIcon: Icon(Icons.home, color: Theme.of(context).disabledColor),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.tour),
        title: "tour".tr,
        inactiveIcon: Icon(Icons.tour, color: Theme.of(context).disabledColor),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.location_on),
        title: "tourist_attraction".tr,
        inactiveIcon:
            Icon(Icons.location_on, color: Theme.of(context).disabledColor),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: "search".tr,
        inactiveIcon:
            Icon(Icons.search, color: Theme.of(context).disabledColor),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.image_rounded),
        title: "VR360",
        inactiveIcon:
            Icon(Icons.image_rounded, color: Theme.of(context).disabledColor),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        GetBuilder<LocalizationController>(builder: (controllerLocalization) {
      return PersistentTabView(
        context,
        controller: _controller,
        screens: pages(),
        items: _navBarItems(context, controllerLocalization),
        resizeToAvoidBottomInset: true,
        navBarStyle: NavBarStyle.style3,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
      );
    }));
  }
}
