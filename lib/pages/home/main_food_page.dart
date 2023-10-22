//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/colors.dart';
import 'package:food_order_app/pages/home/food_page_body.dart';
//import 'package:flutter/widgets/big_text.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:food_order_app/dimensions.dart';
import 'package:food_order_app/widgets/small_text.dart';
class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}
class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print("currrent height is "+MediaQuery.of(context).size.height.toString());
    return  Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(child:Container(
            child: Container(
              margin: EdgeInsets.only(top:Dimensions.height45,bottom:Dimensions.height45),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Column(
                      children:[
                        BigText(text: "Rajkot", color: AppColors.mainColor,),
                        Row(
                          children: [
                            SmallText(text: "Naesingdi", color:Colors.black54,),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),

                      ],
                    ),
                    Center(
                      child: Container(
                        width:Dimensions.height45,
                        height:Dimensions.height45 ,
                        child:Icon(Icons.search, color:Colors.white,size:Dimensions.iconSize24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color:Colors.greenAccent,
                        ),
                      ),
                    )
                  ]
              ),
            ),
          ) ,),
          //show the header

          //showing the body
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ],
      ),
    );
  }
}
