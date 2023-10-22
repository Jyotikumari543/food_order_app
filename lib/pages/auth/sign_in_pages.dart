import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/colors.dart';
import 'package:food_order_app/dimensions.dart';
import 'package:food_order_app/pages/auth/sign_up_page.dart';
import 'package:food_order_app/widgets/app_text_field.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../route/route_helper.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        ShowCustomMessage("Type in your email address", title: "Email Address");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomMessage("Type in a valid email address", title: "Valid Email Address");
      } else if (password.isEmpty) {
        ShowCustomMessage("Type in your password", title: "Password");
      } else if (password.length < 6) {
        ShowCustomMessage("Password cannot be less than six characters", title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomMessage(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.screenHeight * 0.05),
                Container(
                  height: Dimensions.screenHeight * 0.25,
                  width: 400,
                  alignment: Alignment.center,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      backgroundImage: AssetImage("assets/images/logo1.jpeg"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: Dimensions.font20 * 2 + Dimensions.font20 / 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email,
                ),
                SizedBox(height: Dimensions.height20),
                AppTextField(
                  textController: passwordController,
                  hintText: "Password",
                  icon: Icons.lock,
                  isObscure: true,
                ),
                SizedBox(height: Dimensions.height20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(SignUpPage()),
                        text: "Sign up for an account",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWight / 2,
                    height: Dimensions.screenHeight / 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      //onPressed: () => _login(authController),
                      child: BigText(
                        text: "Sign In",
                        size: Dimensions.font20 + Dimensions.font20 / 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignUpPage(), transition: Transition.fade),
                            text: "Create",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}
