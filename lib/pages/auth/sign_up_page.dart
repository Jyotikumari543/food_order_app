//import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/base/custom_loader.dart';
import 'package:food_order_app/colors.dart';
import 'package:food_order_app/controllers/auth_controller.dart';
import 'package:food_order_app/dimensions.dart';
import 'package:food_order_app/models/signup_body_model.dart';
import 'package:food_order_app/pages/auth/sign_in_pages.dart';
import 'package:food_order_app/widgets/app_text_field.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_message.dart';
import '../../route/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var sighupImages=[
      "g.png",
      "i.png",
      "f.png"
    ];

    void _registration(AuthController authController){
      //var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        ShowCustomMessage("Type in your name" ,title: "Name");

      }else if(phone.isEmpty){
        ShowCustomMessage("Type in your phone number" ,title: "phone number");
      }else if(email.isEmpty){
        ShowCustomMessage("Type in your email address" ,title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        ShowCustomMessage("Type in a valid email address" ,title: "valid Email Address");
      }else if(password.isEmpty){
        ShowCustomMessage("Type in your password" ,title: "password");
      }else if(password.length<6){
        ShowCustomMessage("Password cannot be less than six characters" ,title: "Password");
      }else{

        //ShowCustomMessage("All went well ", title: "Perfect",);
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone,
            password: password,
            email: email);
        //print(signUpBody.toString());
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());

          }else{
            ShowCustomMessage(status.message);
          }
        });
      }
    }



    return Scaffold(
        backgroundColor: Colors.white,
        body:GetBuilder<AuthController>(builder: (_authController){
          return  !_authController.isLoading?SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimensions.screenHeight * 0.05),
                Container(
                  height: Dimensions.screenHeight * 0.25,
                  width: 400,
                  alignment: Alignment.center,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70,
                      backgroundImage: AssetImage("assets/images/logo1.jpeg"),
                    ),
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
                  icon: Icons.password_sharp,isObscure: true,
                ),
                SizedBox(height: Dimensions.height20),
                AppTextField(
                  textController: nameController,
                  hintText: "Name",
                  icon: Icons.person,
                ),
                SizedBox(height: Dimensions.height20),
                AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone,
                ),
                SizedBox(height: Dimensions.height20),

                GestureDetector(
                  onTap: (){
                    _registration(_authController);
                  },
                  child: Container(
                    width: Dimensions.screenWight/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: BigText(
                        text: "Sign up",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(text: TextSpan(

                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=> SignInPage()),
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListEmp()));
                      text: "Having an account already?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),

                    )
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                RichText(text: TextSpan(
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16
                    )
                )
                ),
                Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                          "assets/images/" +sighupImages[index]
                      ),
                    ),

                  ),
                  ),
                )
              ],
            ),
          ):const CustomLoader();
        })



    );


  }
}
