// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class RestaurantRepo {
  final ApiClient apiClient;

  RestaurantRepo({
    required this.apiClient,
  });

  Future<Response> getAllRestaurantInfor({String? paramater}) async {
    // Kiểm tra nếu paramater không được cung cấp, sử dụng chuỗi rỗng
    paramater ??= "";

    print("setting url: " + AppConstants.RESTAURANT_URL);

    // Sử dụng paramater trong URL nếu nó được cung cấp
    String url = AppConstants.RESTAURANT_URL;
    if (paramater != null && paramater.isNotEmpty) {
      url += "?filter=" + paramater;
    }

    return await apiClient.getData(url);
  }
}
