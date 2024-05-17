import 'package:flutter_babe/data/repository/post_repo.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController implements GetxService {
  final PostRepo postRepo;
  SharedPreferences sharedPreferences;
  PostController({required this.postRepo, required this.sharedPreferences});
  List<Post> _postList = [];
  List<Post> get postList => _postList;

  List<Post> _postListFilter = [];
  List<Post> get postListFilter => _postListFilter;

  // List<Post> _filterDayPostList = [];
  // List<Post> get filterdayPostList => _filterDayPostList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getAllPostList() async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "";
    try {
      _postList.clear();
      Response response = await postRepo.getAllPostInfor(locale: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((postData) {
          Post post = Post.fromJson(postData);
          _postList.add(post);
        });
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
  }

  Future<void> getPostListByFilter(String filter) async {
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await postRepo.getAllPostInfor(locale: language, filter: filter);
      if (response.statusCode == 200) {
        _postListFilter.clear();
        update();
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((postData) async {
          Post post = Post.fromJson(postData);
          _postListFilter.add(post);
        });
        update();
      } else {}
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
    _isLoading = false;
    update();
  }

  Post getPostByPostID(int postID) {
    for (Post post in _postList) {
      if (post.id == postID) {
        return post;
      }
    }
    return Post();
  }

  // if something went wrong, you have to get post by filter according to this way

  // Future<void> getFilterPostByDayList() async {
  //   try {
  //     Response response = await postRepo.getAllPostInfor(paramater: "day");
  //     if (response.statusCode == 200) {
  //       _isLoaded = true;
  //       _filterDayPostList.clear();
  //       List<dynamic> dataList = response.body["results"];
  //       dataList.forEach((postData) {
  //         Post post = Post.fromJson(postData);
  //         _filterDayPostList.add(post);
  //       });
  //       update();
  //     } else {}
  //   } catch (e) {
  //     // Handle exceptions or errors
  //     print("Error in getTourList: $e");
  //   }
  // }
}
