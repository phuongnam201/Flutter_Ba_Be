import 'package:flutter/material.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class MenuSlider extends StatelessWidget {
  const MenuSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: BigText(
              text: "PhuongNam201",
              color: Colors.white,
            ),
            accountEmail: SmallText(
              text: "admin@admin.com",
              color: Colors.white,
              size: Dimensions.font16,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Container(
                  height: 90,
                  width: 90,
                  child: Image.asset(
                    "assets/images/user.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ho_ba_be_tren_cao.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: SmallText(
              text: 'home'.tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {
              Navigator.pop(context);
              //Get.offAll(HomePage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.newspaper,
              color: Colors.blue,
            ),
            title: SmallText(
              text: "news".tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {
              Get.toNamed(RouteHelper.getNewsPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.tour_outlined,
              color: Colors.blue,
            ),
            title: SmallText(
              text: "tour".tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {
              Get.toNamed(RouteHelper.getTourPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.blue,
            ),
            title: SmallText(
              text: "notification".tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {
              Get.toNamed(RouteHelper.getNotificationPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.blue,
            ),
            title: SmallText(
              text: "languages".tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {
              Get.toNamed(RouteHelper.getLanguageRoute());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            title: SmallText(
              text: "about_us".tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {
              Get.toNamed(RouteHelper.getAboutUsPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_support,
              color: Colors.blue,
            ),
            title: SmallText(
              text: "contact".tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {
              Get.toNamed(RouteHelper.getContactPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            title: SmallText(
              text: "logout".tr,
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
