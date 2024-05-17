import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/app_text_filed.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var textController = TextEditingController();
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
        appBar: AppBar(
          title: Text("search".tr),
          // leading: IconButton(
          //     icon: Icon(Icons.arrow_back_ios),
          //     onPressed: () => Get.toNamed(RouteHelper.getMenuPage()),
          // ),
        ),
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
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/banner.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 85),
                    //height: Dimensions.screenHeight,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppTextField(
                            textController: textController,
                            labelText: "search".tr,
                            icon: Icons.search),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Container(
                          //height: Dimensions.screenHeight,
                          child: showNews(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

Widget showNews() {
  return Container(
    child: ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildItemNews(index);
      },
    ),
  );
}

Widget _buildItemNews(int index) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  return Container(
    height: Dimensions.height10 * 12,
    width: Dimensions.screenWidth,
    margin: EdgeInsets.only(
        left: Dimensions.width20,
        right: Dimensions.width20,
        bottom: Dimensions.height10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius10),
      color: Colors.white,
    ),
    //width: 350,
    //color: Colors.amber,

    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Dimensions.height10 * 12,
          width: Dimensions.screenWidth * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius10),
                bottomLeft: Radius.circular(Dimensions.radius10)),
            image: DecorationImage(
                image: AssetImage("assets/images/ho_ba_be.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          width: Dimensions.screenWidth * 0.55,
          margin: EdgeInsets.only(
              left: Dimensions.width10, right: Dimensions.width10),
          decoration: BoxDecoration(
              //color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius10),
                  bottomRight: Radius.circular(Dimensions.radius10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.width10 * 23,
                margin: EdgeInsets.only(top: Dimensions.height10),
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, top: 2, right: 10, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber[600],
                      ),
                      child: Center(
                        child: BigText(
                          text: "New",
                          color: Colors.white,
                          size: Dimensions.font16,
                        ),
                      ),
                    ),
                    SmallText(
                      text: formattedDate,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: Dimensions.width10 * 23,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "This is title of the news",
                      size: Dimensions.font16,
                      color: Colors.blue[600],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SmallText(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce auctor metus eu turpis cursus, eget vestibulum nunc varius. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin eget convallis libero. Donec non velit a velit bibendum finibus. Nullam euismod consequat libero, eget pulvinar velit fermentum vel. Nulla eget purus at magna convallis sollicitudin. Integer id lectus eget nibh posuere sodales.",
                      maxLines: 2,
                      size: Dimensions.font16,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
