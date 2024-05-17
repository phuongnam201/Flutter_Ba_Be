import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/models/signup_model.dart';
import 'package:flutter_babe/pages/auth/sign_in_page.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/app_text_filed.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  var signUpImage = ["facebook.png", "google.png"];

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // Your build method code here
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    Container(
                      height: Dimensions.screenHeight * 0.20,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          backgroundImage: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    Text(
                      "Sign Up",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        textController: nameController,
                        labelText: "Name",
                        icon: Icons.person),
                    AppTextField(
                        textController: emailController,
                        labelText: "Email",
                        icon: Icons.email),
                    AppTextField(
                      textController: passwordController,
                      labelText: "Password",
                      icon: Icons.password,
                      obscureText: true,
                    ),
                    AppTextField(
                      textController: rePasswordController,
                      labelText: "Confirm password",
                      icon: Icons.password,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _registration();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        width: double.maxFinite,
                        height: Dimensions.screenHeight / 15,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                        ),
                        child: Center(
                          child: BigText(
                            text: "Register",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    RichText(
                      text: TextSpan(
                        //recognizer: TapGestureRecognizer()
                        // ..onTap = () => Get.to(() => SignInPage()),
                        text: "Have an account already? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.font16,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignInPage()),
                            text: "Sign In",
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: Dimensions.font16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Sign up using one of the following methods",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                    Wrap(
                      children: List.generate(
                          signUpImage.length,
                          (index) => Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: Dimensions.radius20,
                                  backgroundImage: AssetImage(
                                      "assets/images/" + signUpImage[index]),
                                ),
                              )),
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  void _registration() {
    var authController = Get.find<AuthController>();
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String rePassword = rePasswordController.text.trim();

    if (name.isEmpty) {
      CustomSnackBar("Please enter your name!", title: "Name");
    } else if (email.isEmpty) {
      CustomSnackBar("Please enter your email!", title: "Email");
    } else if (!GetUtils.isEmail(email)) {
      CustomSnackBar("Please enter a valid email!",
          title: "Email is not valid");
      CustomSnackBar("Please enter your email!", title: "Email");
    } else if (password.isEmpty) {
      CustomSnackBar("Please enter your password!", title: "Password");
    } else if (password.length <= 5) {
      CustomSnackBar("Password must have more 6 characters!",
          title: "Password");
    } else if (rePassword != password) {
      CustomSnackBar("Password does not match!", title: "Password");
    } else {
      SignUpModel signUpModel =
          SignUpModel(name: name, email: email, password: password);
      print(signUpModel.toJson());
      print("result" + authController.registration(signUpModel).toString());
      authController.registration(signUpModel).then((status) {
        if (status.isSuccess) {
          print("ok");
        } else {
          SnackBar(
            content: Text(status.message),
          );
        }
      });
    }
  }
}
