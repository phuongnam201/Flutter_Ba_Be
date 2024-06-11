import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/pages/news/newspage_tabbar.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  PageController pageController = PageController(viewportFraction: 0.95);
  var _currentPageValue = 0.0;
  //double _scaleFactor = 0.8;
  //double _height = Dimensions.pageViewContainer;

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
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetBuilder<PostController>(builder: (postController) {
        return Scaffold(
            appBar: AppBar(
              title: Text("news".tr),
              centerTitle: true,
            ),
            backgroundColor: Colors.grey[200],
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
              child: Container(
                //color: Colors.amber,
                width: Dimensions.screenWidth,
                //margin: EdgeInsets.only(left: Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Dimensions.screenWidth,
                      margin: EdgeInsets.only(
                          top: Dimensions.height15, left: Dimensions.width15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          //high light post
                          PictureWidget(pageController, _currentPageValue,
                              postController.featurePostList),
                          //SizedBox(height: Dimensions.height10,),
                          //tab view post
                          NewsContentTabBar(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
    });
  }
}

Widget PictureWidget(PageController pageController, var _currentPageValue,
    List<Post> postFeatureList) {
  return Stack(
    children: [
      Container(
        //padding: EdgeInsets.all(10),
        height: Dimensions.height200,
        width: Dimensions.screenWidth,
        child: PageView.builder(
          itemCount: postFeatureList.length,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          padEnds: false,
          itemBuilder: (context, index) {
            return _buildPageItem(postFeatureList[index]);
          },
        ),
      ),
      Positioned(
        bottom: Dimensions.height10,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DotsIndicator(
              dotsCount: postFeatureList.length,
              position: _currentPageValue,
              decorator: const DotsDecorator(
                color: Colors.white, // Inactive color
                activeColor: Colors.amber,
                size: Size.square(6.0),
                activeSize: Size(15.0, 6.0),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildPageItem(Post post) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(RouteHelper.getNewsDetailPage(post.id!, "NewsPage"));
    },
    child: Container(
      height: 200,
      width: Dimensions.screenWidth,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        image: DecorationImage(
          image: NetworkImage(AppConstants.BASE_URL + "storage/" + post.image!),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: Dimensions.height30,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              width: Dimensions.screenWidth * 0.8,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Dimensions.width10 * 10,
                    padding:
                        EdgeInsets.only(left: 20, top: 2, right: 20, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[600],
                    ),
                    child: Center(
                        child: BigText(
                      text: "New",
                      color: Colors.white,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: post.title!,
                    color: Colors.white,
                    size: Dimensions.font20,
                    maxLines: 1,
                  ),
                  SmallText(
                    text: post.metaKeywords!,
                    size: Dimensions.font16,
                    color: Colors.white,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    print("You clicked on icon message");
                  },
                  child: Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                InkWell(
                    onTap: () {
                      print("you clicked on icon share");
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
