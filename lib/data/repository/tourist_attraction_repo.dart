// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class TouristAttractionRepo {
  final ApiClient apiClient;

  TouristAttractionRepo({
    required this.apiClient,
  });

  Future<Response> getTouristAttractionInfor() async {
    // print(
    //   "tourist attraction url: " + AppConstants.TOURIST_ATTRACTION_URL,
    // );
    return await apiClient.getData(
      AppConstants.TOURIST_ATTRACTION_URL,
    );
  }
}
