import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewsContentTabBar extends StatefulWidget {
  const NewsContentTabBar({Key? key}) : super(key: key);

  @override
  _NewsContentTabBarState createState() => _NewsContentTabBarState();
}

class _NewsContentTabBarState extends State<NewsContentTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {}); // Bắt buộc rebuild để cập nhật màu sắc
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (postController) {
      return Container(
        height: Dimensions.screenHeight * 0.9,
        width: Dimensions.screenWidth,
        margin: EdgeInsets.only(right: Dimensions.width15),
        child: Column(
          children: [
            SizedBox(height: Dimensions.height20),
            TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: _tabController.indexIsChanging
                      ? Colors.black
                      : Colors.blue,
                ),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.black),
              tabs: const [
                Tab(text: 'Theo ngày'),
                Tab(text: 'Theo tuần'),
                Tab(text: 'Theo tháng'),
                Tab(text: 'Tất cả'),
              ],
              controller: _tabController,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  showNews(postController.filterdayPostList),
                  showNews(postController.filterWeekPostList),
                  showNews(postController.filterMonthPostList),
                  showNews(postController.postList),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

Widget showNews(List<Post> postList) {
  return Container(
    child: ListView.builder(
      itemCount: postList.length,
      //scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildItemNews(postList[index]);
      },
    ),
  );
}

Widget _buildItemNews(Post post) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  return GestureDetector(
    onTap: () {
      print("id post:" + post.id!.toString());
      Get.toNamed(RouteHelper.getNewsDetailPage(post.id!, "newpage"));
    },
    child: Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        color: Colors.white,
      ),
      //width: 350,
      //color: Colors.amber,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius10),
                  bottomLeft: Radius.circular(Dimensions.radius10)),
              image: DecorationImage(
                  image: post.image != null
                      ? NetworkImage(
                          AppConstants.BASE_URL + "storage/" + post.image!)
                      : AssetImage("assets/images/ho_ba_be.jpg")
                          as ImageProvider,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: Dimensions.width15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 220,
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
                    // SizedBox(
                    //   width: 100,
                    // ),
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
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: post.title!,
                      size: Dimensions.font16,
                      color: Colors.blue[600],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SmallText(
                      text: post.metaDescription!,
                      maxLines: 2,
                      size: Dimensions.font16,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
