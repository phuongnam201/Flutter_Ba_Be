import 'package:flutter_babe/data/repository/post_repo.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:get/get.dart';

class PostController extends GetxController implements GetxService {
  final PostRepo postRepo;
  PostController({required this.postRepo});
  List<Post> _postList = [];
  List<Post> get postList => _postList;

  List<Post> _filterDayPostList = [];
  List<Post> get filterdayPostList => _filterDayPostList;

  List<Post> _filterWeekPostList = [];
  List<Post> get filterWeekPostList => _filterWeekPostList;

  List<Post> _filterMonthPostList = [];
  List<Post> get filterMonthPostList => _filterMonthPostList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAllPostList() async {
    try {
      Response response = await postRepo.getAllPostInfor();
      // print("debug StatusCode at post controller: " +
      //     response.statusCode.toString());
      if (response.statusCode == 200) {
        _isLoaded = true;
        // print("post controller is working properly");
        // Clear the list before adding new items
        _postList.clear();
        // Convert each object in the 'data' array to a Tour object
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((postData) {
          Post post = Post.fromJson(postData);
          _postList.add(post);
        });
        //print(_postList[0]);
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
  }

  Future<void> getFilterPostByDayList() async {
    try {
      Response response = await postRepo.getAllPostInfor(paramater: "day");
      //print("debug StatusCode at filter day post controller: " +
      //     response.statusCode.toString());
      if (response.statusCode == 200) {
        _isLoaded = true;
        //  print("post controller is working properly");
        // Clear the list before adding new items
        _filterDayPostList.clear();
        // Convert each object in the 'data' array to a Tour object
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((postData) {
          Post post = Post.fromJson(postData);
          _filterDayPostList.add(post);
        });
        //print(_filterPostList[0]);
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
  }

  Future<void> getFilterPostByWeekList() async {
    try {
      Response response = await postRepo.getAllPostInfor(paramater: "week");
      //print("debug StatusCode at filter day post controller: " +
      //    response.statusCode.toString());
      if (response.statusCode == 200) {
        _isLoaded = true;
        // print("post controller is working properly");
        // Clear the list before adding new items
        _filterWeekPostList.clear();
        // Convert each object in the 'data' array to a Tour object
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((postData) {
          Post post = Post.fromJson(postData);
          _filterWeekPostList.add(post);
        });
        //print(_filterPostList[0]);
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
  }

  Future<void> getFilterPostByMonthList() async {
    try {
      Response response = await postRepo.getAllPostInfor(paramater: "month");
      //  print("debug StatusCode at filter day post controller: " +
      //    response.statusCode.toString());
      if (response.statusCode == 200) {
        _isLoaded = true;
        // print("post controller is working properly");
        // Clear the list before adding new items
        _filterMonthPostList.clear();
        // Convert each object in the 'data' array to a Tour object
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((postData) {
          Post post = Post.fromJson(postData);
          _filterMonthPostList.add(post);
        });
        //print(_filterPostList[0]);
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTourList: $e");
    }
  }

  Post getPostByPostID(int postID) {
    for (Post post in _postList) {
      if (post.id == postID) {
        return post;
      }
    }
    // Nếu không tìm thấy post nào có ID tương ứng, bạn có thể trả về một giá trị mặc định hoặc xử lý theo cách khác tùy thuộc vào yêu cầu của ứng dụng.
    // Ở đây tôi trả về một post rỗng
    return Post();
  }

  // Future<List<Post>> getFilteredPostList(String? filterType) async {
  //   List<Post> postListInFliter = [];
  //   try {
  //     Response response = await postRepo.getAllPostInfor(paramater: filterType);
  //     _isLoaded = response.statusCode == 200;
  //     if (_isLoaded) {
  //       _isLoaded = true;
  //       print("post controller is working properly");
  //       // Clear the list before adding new items
  //       postListInFliter.clear();
  //       // Convert each object in the 'data' array to a Tour object
  //       List<dynamic> dataList = response.body["results"];
  //       dataList.forEach((postData) {
  //         Post post = Post.fromJson(postData);
  //         postListInFliter.add(post);
  //       });
  //     }
  //   } catch (e) {
  //     print("Error in getFilteredPostList: $e");
  //   }
  //   return postListInFliter;
  // }
}
