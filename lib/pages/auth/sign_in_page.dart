import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/pages/auth/sign_up_page.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/app_text_filed.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var signUpImage = ["facebook.png", "google.png"];

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        CustomSnackBar("Please enter your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        CustomSnackBar("Please enter a valid email", title: "Email");
      } else if (password.isEmpty) {
        CustomSnackBar("Please enter your password!", title: "Password");
      } else if (password.length <= 5) {
        CustomSnackBar("Password must have more 6 characters!",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            CustomSnackBar(status.message!);
            Get.toNamed(RouteHelper.getMenuPage());
            print("login ok");
          } else {
            CustomSnackBar(status.message!);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (controller) {
          return Container(
            child: SingleChildScrollView(
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
                    "Sign In",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _login(controller);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      width: double.maxFinite,
                      height: Dimensions.screenHeight / 15,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      child: Center(
                        child: BigText(
                          text: "Login",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "Forgot password",
                            style: TextStyle(
                              color: Colors.red[400],
                              fontSize: Dimensions.font16,
                            ),
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
                      //recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage()),
                          text: "Create",
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
                      text: "Log in with",
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
                          backgroundImage:
                              AssetImage("assets/images/" + signUpImage[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
