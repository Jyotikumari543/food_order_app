import 'package:flutter/material.dart';
import 'package:food_order_app/colors.dart';
import 'package:food_order_app/pages/account/account_widget.dart';
import 'package:food_order_app/widgets/app_icon.dart';
import 'package:food_order_app/widgets/big_text.dart';

import '../../dimensions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Account",
          size: 24,
          color: Colors.white,
        ),
      ),
      body:  Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //profile icon
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45 + Dimensions.height30,
                size: Dimensions.height15 * 10,

              ),
              SizedBox(height: Dimensions.height30,),
               Expanded(child: SingleChildScrollView(
                 child: Column(
                   children: [
                     //name
                     AccountWidget(
                       appIcon: AppIcon(
                         icon: Icons.person,
                         backgroundColor: AppColors.mainColor,
                         iconColor: Colors.white,
                         iconSize: Dimensions.height10 * 5 / 2,
                         size: Dimensions.height10 * 5,
                       ),
                       bigText: BigText(text: "Jyoti Kumari"),
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //phone
                     AccountWidget(
                       appIcon: AppIcon(
                         icon: Icons.phone,
                         backgroundColor: AppColors.yelloColor,
                         iconColor: Colors.white,
                         iconSize: Dimensions.height10 * 5 / 2,
                         size: Dimensions.height10 * 5,
                       ),
                       bigText: BigText(text: "1234567890"),
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //email
                     AccountWidget(
                       appIcon: AppIcon(
                         icon: Icons.email,
                         backgroundColor: AppColors.yelloColor,
                         iconColor: Colors.white,
                         iconSize: Dimensions.height10 * 5 / 2,
                         size: Dimensions.height10 * 5,
                       ),
                       bigText: BigText(text: "Jyotithakurja@gmail.com"),
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //address
                     AccountWidget(
                       appIcon: AppIcon(
                         icon: Icons.place,
                         backgroundColor: AppColors.yelloColor,
                         iconColor: Colors.white,
                         iconSize: Dimensions.height10 * 5 / 2,
                         size: Dimensions.height10 * 5,
                       ),
                       bigText: BigText(text: "Rajkot,Gujraat"),
                     ),
                     SizedBox(height: Dimensions.height20,),
                     //message
                     AccountWidget(
                       appIcon: AppIcon(
                         icon: Icons.message,
                         backgroundColor:Colors.redAccent,
                         iconColor: Colors.white,
                         iconSize: Dimensions.height10 * 5 / 2,
                         size: Dimensions.height10 * 5,
                       ),
                       bigText: BigText(text: "Jyoti"),
                     ),
                     SizedBox(height: Dimensions.height20,),
                   ],
                 ),
               ))

            ],
          ),
        ),
      //),
    );
  }
}
