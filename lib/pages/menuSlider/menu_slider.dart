import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/controller/user_controller.dart';
import 'package:flutter_babe/models/user_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class MenuSlider extends StatefulWidget {
  const MenuSlider({super.key});

  @override
  State<MenuSlider> createState() => _MenuSliderState();
}

class _MenuSliderState extends State<MenuSlider> {
  var auth = Get.find<AuthController>().userLoggedIn();
  late UserController userController;
  UserModel? userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (auth) {
      userController = Get.find<UserController>();
      userController.getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: auth
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  GetBuilder<UserController>(builder: (controller) {
                    return UserAccountsDrawerHeader(
                      accountName: BigText(
                        text: controller.userModel?.name ?? "loading",
                        color: Colors.white,
                      ),
                      accountEmail: SmallText(
                        text: controller.userModel?.email ?? "loading",
                        color: Colors.white,
                        size: Dimensions.font16,
                      ),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: Container(
                            height: 90,
                            width: 90,
                            child: controller.userModel?.avatar != null
                                ? Image.network(
                                    AppConstants.BASE_URL +
                                        "storage/" +
                                        controller.userModel!.avatar!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          "assets/images/user.jpg");
                                    },
                                  )
                                : Image.asset("assets/images/user.jpg"),
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/ho_ba_be_tren_cao.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
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
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: SmallText(
                      text: 'profile'.tr,
                      size: Dimensions.font16,
                      color: AppColors.mainBlackColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(RouteHelper.getProfile());
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
                      Icons.archive_rounded,
                      color: Colors.blue,
                    ),
                    title: SmallText(
                      text: "booking_history".tr,
                      size: Dimensions.font16,
                      color: AppColors.mainBlackColor,
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getHistoryBook());
                      // Get.snackbar("Ba_Be_Tourism".tr, "coming soon!",
                      //     colorText: Colors.white,
                      //     backgroundColor: Colors.blue);
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
                  //logout
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
                    onTap: () {
                      Get.find<AuthController>().clearShareData();
                      Navigator.pop(context);
                      Get.snackbar(":((", "You logged out!, See you later",
                          backgroundColor: Colors.amber[300]);
                    },
                  ),
                ],
              )
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logobabe.png",
                      height: Dimensions.height20 * 5,
                      width: Dimensions.width20 * 5,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    BigText(text: "please_login".tr),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSignInPage());
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        width: double.maxFinite,
                        height: Dimensions.screenHeight / 15,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                        ),
                        child: Center(
                          child: BigText(
                            text: "login".tr,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
