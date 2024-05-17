// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/models/languages.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/pages/news/widgets/showNews_widget.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';

class NewsDetail extends StatefulWidget {
  int postID;
  String pageID;
  NewsDetail({
    Key? key,
    required this.postID,
    required this.pageID,
  }) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var post = Get.find<PostController>().getPostByPostID(widget.postID);
    int language_index = Get.find<LocalizationController>().selectedIndex;
    print(language_index);
    DateTime createdPost = DateTime.parse(post.createdAt!);
    String formattedDateVi = DateFormat('dd-MM-yyyy').format(createdPost);
    String formattedDateUs = DateFormat('yyyy-MM-dd').format(createdPost);
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return Scaffold(
        appBar: AppBar(
          title: Text("news_detail".tr),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: Dimensions.height200,
                    width: Dimensions.screenWidth,
                    //margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radius20),
                          bottomRight: Radius.circular(Dimensions.radius20)),
                      image: DecorationImage(
                        image: NetworkImage(
                            AppConstants.BASE_URL + "storage/" + post.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.height20,
                    right: Dimensions.width20,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              print("you clicked on icon share");
                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          InkWell(
                            onTap: () {
                              print("you clicked on icon favorite");
                              setState(() {
                                // Khi nhấp vào, chuyển đổi trạng thái của biểu tượng
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color:
                                  isFavorite ? Colors.amber[700] : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                width: Dimensions.screenWidth,
                margin: EdgeInsets.all(Dimensions.height20),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Màu sắc của đường border
                      width: 1.0, // Độ dày của đường border
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Dimensions.width20 * 6,
                      padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          top: Dimensions.height10 / 2,
                          right: Dimensions.width20,
                          bottom: Dimensions.height10 / 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber[600],
                      ),
                      child: Center(
                          child: BigText(
                        text: "news".tr,
                        color: Colors.white,
                        size: Dimensions.font16,
                      )),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    BigText(
                      text: post.title!,
                      color: Colors.blue[800],
                      size: Dimensions.font20,
                      maxLines: 4,
                    ),
                    SizedBox(
                      height: Dimensions.height10 / 2,
                    ),
                    Container(
                      //color: Colors.amber,
                      width: Dimensions.screenWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Container(
                          //   width: Dimensions.screenWidth * .5,
                          //   child: SmallText(
                          //     text: post.metaDescription!,
                          //     size: Dimensions.font16,
                          //     color: Colors.blue[800],
                          //     maxLines: 3,
                          //   ),
                          // ),
                          Container(
                            //width: Dimensions.screenWidth * .4,
                            child: Row(children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Colors.grey,
                              ),
                              SmallText(
                                  text: language_index == 1
                                      ? formattedDateVi
                                      : formattedDateUs,
                                  maxLines: 1)
                            ]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10 / 2,
                    ),
                  ],
                ),
              ),
              //content
              Container(
                width: Dimensions.screenWidth,
                margin: EdgeInsets.only(
                    left: Dimensions.height20, right: Dimensions.height20),
                child: HtmlWidget(post.body!),
              ),
              //Feed back
              Container(
                width: Dimensions.screenWidth,
                margin: EdgeInsets.all(Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "comment".tr,
                      color: Colors.blue[800],
                      size: Dimensions.font20,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    feedBack()
                  ],
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(Dimensions.height20),
                      child: BigText(
                        text: "highlight_tour".tr,
                        color: Colors.blue[800],
                        size: Dimensions.font20,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: ShowNews())
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              )
            ],
          ),
        ),
      );
    });
  }
}

Widget feedBack() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return Container(
    width: Dimensions.screenWidth,
    child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: Dimensions.screenWidth,
            height: Dimensions.height10 * 8,
            decoration: BoxDecoration(
              //color: Colors.amber,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey, // Màu sắc của đường border
                  width: 1.0, // Độ dày của đường border
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  margin: EdgeInsets.all(Dimensions.height10),
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 100,
                        child: BigText(
                          text: "Nguyen Phuong Nam",
                          maxLines: 2,
                          size: Dimensions.font16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.height10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 3, top: 2, right: 3, bottom: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.amber[600],
                            ),
                            child: Center(
                              child: SmallText(
                                text: "10",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          BigText(
                            text: "Tuyệt vời",
                            size: Dimensions.font16,
                            color: Colors.grey[600],
                          ),
                          SizedBox(
                            width: Dimensions.width10 * 3.5,
                          ),
                          SmallText(text: formattedDate),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      Container(
                        //color: Colors.blue,
                        width: Dimensions.width10 * 20,
                        child: SmallText(
                          text:
                              "good good good very. That is the first time i have been there.",
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
  );
}
