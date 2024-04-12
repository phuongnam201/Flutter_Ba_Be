import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class PlacesRepo {
  final ApiClient apiClient;

  PlacesRepo({
    required this.apiClient,
  });

  Future<Response> getAllPlaceInfor({String? paramater}) async {
    paramater ??= "";

    // print("setting url: " + AppConstants.PLACES_URL);

    String url = AppConstants.PLACES_URL;
    if (paramater != null && paramater.isNotEmpty) {
      url += "?filter=" + paramater;
    }

    return await apiClient.getData(url);
  }
}
