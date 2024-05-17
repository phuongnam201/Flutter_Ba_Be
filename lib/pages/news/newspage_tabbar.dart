import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    // Load initial data
    _loadDataForTab(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      _loadDataForTab(_tabController.index);
    }
  }

  String _getFilterByIndex(int index) {
    switch (index) {
      case 0:
        return "day";
      case 1:
        return "week";
      case 2:
        return "month";
      case 3:
        return "all";
      default:
        return "all";
    }
  }

  void _loadDataForTab(int index) async {
    setState(() {
      _isLoading = true;
    });
    String filter = _getFilterByIndex(index);
    await Get.find<PostController>().getPostListByFilter(filter);
    setState(() {
      _isLoading = false;
    });
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
            SizedBox(height: Dimensions.height20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        showNews(),
                        showNews(),
                        showNews(),
                        showNews(),
                      ],
                    ),
            ),
          ],
        ),
      );
    });
  }
}

Widget showNews() {
  return GetBuilder<PostController>(builder: (controller) {
    return ListView.builder(
      itemCount: controller.postListFilter.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildItemNews(controller.postListFilter[index]);
      },
    );
  });
}

Widget _buildItemNews(Post post) {
  int language_index = Get.find<LocalizationController>().selectedIndex;
  DateTime createdPost = DateTime.parse(post.createdAt!);
  String formattedDateVi = DateFormat('dd-MM-yyyy').format(createdPost);
  String formattedDateUs = DateFormat('yyyy-MM-dd').format(createdPost);
  return GestureDetector(
    onTap: () {
      print("id post:" + post.id!.toString());
      Get.toNamed(RouteHelper.getNewsDetailPage(post.id!, "newpage"));
    },
    child: Container(
      height: Dimensions.height10 * 13,
      width: Dimensions.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: Dimensions.height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.height10 * 13,
            width: Dimensions.screenWidth * 0.3,
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
          Container(
            width: Dimensions.screenWidth * 0.57,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Dimensions.screenWidth * 0.6,
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
                        text: language_index == 1
                            ? formattedDateVi
                            : formattedDateUs,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Container(
                  width: Dimensions.width10 * 24,
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
            ),
          )
        ],
      ),
    ),
  );
}
