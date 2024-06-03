import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/controller/user_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController reEnterPasswordController;

  late UserController userController;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    authController = Get.find<AuthController>();
    userController.getUserInfo();
    fullName = TextEditingController();
    email = TextEditingController();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    reEnterPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (authController.userLoggedIn()) {
      return GetBuilder<UserController>(builder: (controller) {
        if (controller.userModel != null) {
          fullName.text = controller.userModel!.name ?? '';
          email.text = controller.userModel!.email ?? '';
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("profile".tr),
          ),
          body: controller.userModel != null
              ? Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 211, 201, 201),
                                      offset: const Offset(
                                        1.5,
                                        1.5,
                                      ),
                                      blurRadius: 2.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Stack(children: [
                                  //image
                                  CircleAvatar(
                                    radius: 70.0,
                                    backgroundImage: controller.pickedImage !=
                                            null
                                        ? FileImage(controller.pickedImage!)
                                        : NetworkImage(AppConstants.BASE_URL +
                                            "/storage/" +
                                            (controller.userModel!.avatar ??
                                                '')) as ImageProvider,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.amber[600],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            controller.pickImage();
                                          },
                                        ),
                                      ))
                                ]),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              BigText(text: "profile".tr),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: Dimensions.screenWidth,
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
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),

                          //information
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Name
                              Text("fullname".tr),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              TextField(
                                keyboardType: TextInputType.name,
                                controller: fullName,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              // Email
                              Text("email".tr),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: email,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              // Button
                              Center(
                                child: ElevatedButton(
                                  child: Text('save'.tr),
                                  onPressed: () {
                                    controller.updateUserInfo(
                                        fullName.text, email.text, null);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber[700],
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //password
                        SizedBox(
                          height: Dimensions.height45,
                        ),
                        BigText(text: "change_password".tr),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: Dimensions.screenWidth,
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
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          //information
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Current Password
                              Text("current_password".tr),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              TextField(
                                keyboardType: TextInputType.name,
                                controller: currentPasswordController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              // New Password
                              Text("new_password".tr),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: newPasswordController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              // Re-enter Password
                              Text("re_password".tr),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: reEnterPasswordController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),

                              // Button
                              Center(
                                child: ElevatedButton(
                                  child: Text('save'.tr),
                                  onPressed: () {
                                    // Implement password update logic
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber[700],
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        )
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(RouteHelper.getSignInPage());
      });
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
