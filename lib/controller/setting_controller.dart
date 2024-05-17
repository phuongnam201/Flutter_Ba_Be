// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_babe/data/repository/setting_repo.dart';
import 'package:flutter_babe/models/response_model.dart';
import 'package:flutter_babe/models/setting_modal.dart';

class SettingController extends GetxController implements GetxService {
  final SettingRepo settingRepo;
  SharedPreferences sharedPreferences;
  SettingController({
    required this.settingRepo,
    required this.sharedPreferences,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SettingModel? _settingModel;
  SettingModel? get settingModel => _settingModel;

  Future<ResponseModel> getSetting() async {
    late ResponseModel responseModel;
    Response response = await settingRepo.getSettingInfor(
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi');
    if (response.statusCode == 200) {
      _settingModel = SettingModel.fromJson(response.body["results"]);
      _isLoading = true;
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel =
          ResponseModel(false, response.statusText ?? "Unknown error");
    }

    _isLoading = false;
    update();

    return responseModel;
  }
}
