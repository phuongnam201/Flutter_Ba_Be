import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/about_us_controller.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late AboutUsController aboutUsController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aboutUsController = Get.find<AboutUsController>();
    aboutUsController.getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: Text("about_us".tr),
            //backgroundColor: AppColors.green400,
          ),
          body: !controller.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: Dimensions.screenWidth,
                        //margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(Dimensions.radius20),
                              bottomRight:
                                  Radius.circular(Dimensions.radius20)),
                          image: DecorationImage(
                            image: AssetImage('assets/images/ho_ba_be.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 120),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: BigText(
                                      text: 'about'.tr,
                                      color: Colors.white,
                                      size: Dimensions.font26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      BigText(
                        text: controller.aboutUsModel!.title!,
                        size: Dimensions.font26,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width30,
                              right: Dimensions.width30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HtmlWidget(
                                controller.aboutUsModel!.body!,
                                textStyle: TextStyle(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator()));
    });
  }
}
