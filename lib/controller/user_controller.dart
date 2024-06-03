import 'dart:io';
import 'package:flutter_babe/data/repository/user_repo.dart';
import 'package:flutter_babe/models/response_model.dart';
import 'package:flutter_babe/models/update_user_model.dart';
import 'package:flutter_babe/models/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  UserModel? _userModel = null;
  File? _pickedImage;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  File? get pickedImage => _pickedImage;

  Future<ResponseModel> getUserInfo() async {
    late ResponseModel responseModel;
    Response response = await userRepo.getUserInformation();

    print("code: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body["results"]);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      print("false at usercontroller");
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> updateUserInfo(
      String name, String email, String? password) async {
    _isLoading = true;
    update();
    UpdateUserModel updatedUser = UpdateUserModel(
      name: name,
      email: email,
      avatar: _pickedImage,
      password: password,
    );

    var response = await userRepo.updateUserInformation(updatedUser);
    if (response.statusCode == 200) {
      // Update local user model with new data
      _userModel = UserModel(
        id: _userModel?.id,
        name: name,
        email: email,
        avatar: _pickedImage?.path.split('/').last,
        createdAt: _userModel?.createdAt,
        updatedAt: DateTime.now().toString(),
      );
    }
    _isLoading = false;
    update();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedImage = File(pickedFile.path);
    }
    update();
  }
}
