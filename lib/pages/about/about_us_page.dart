import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/expandable_text_widget.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizationController){
      return Scaffold(
        appBar: AppBar(
          title: Text("about_us".tr),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: Dimensions.screenWidth,
                //margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.radius20), bottomRight: Radius.circular(Dimensions.radius20) ),
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
                          // SmallText(
                          //   text: "Lorem",
                          //   size: Dimensions.font16,
                          //   color: Colors.white,
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height30,),
              BigText(text: "our_mission".tr, size: Dimensions.font26, color: Colors.blue,),
              SizedBox(height: Dimensions.height30,),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpandableTextWidget(text: "Chúng tôi là một công ty du lịch hàng đầu, tập trung vào việc cung cấp những trải nghiệm du lịch độc đáo và không quên được cho khách hàng. Với đội ngũ nhân viên chuyên nghiệp và niềm đam mê không ngừng, chúng tôi cam kết mang lại dịch vụ chất lượng cao và những kỷ niệm đáng nhớ cho mỗi chuyến hành trình của bạn.", showSeeLessOrMore: true,),
                    SizedBox(height: 20,),
                    ExpandableTextWidget(text: "Chúng tôi là một công ty du lịch hàng đầu, tập trung vào việc cung cấp những trải nghiệm du lịch độc đáo và không quên được cho khách hàng. Với đội ngũ nhân viên chuyên nghiệp và niềm đam mê không ngừng, chúng tôi cam kết mang lại dịch vụ chất lượng cao và những kỷ niệm đáng nhớ cho mỗi chuyến hành trình của bạn.", showSeeLessOrMore: true,),
                    SizedBox(height: 20,),
                    SmallText(text: "Vui lòng liên hệ: 0999999999", color: Colors.grey,)
                  ],
                ))
            ],
          ),
        ),
      );
    });

  }
}