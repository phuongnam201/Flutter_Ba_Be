// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class TourRepo {
  final ApiClient apiClient;

  TourRepo({
    required this.apiClient,
  });

  Future<Response> getTourInfor() async {
    // print(
    //   "setting url: " + AppConstants.TOUR_URL,
    // );
    return await apiClient.getData(
      AppConstants.TOUR_URL,
    );
  }
}
