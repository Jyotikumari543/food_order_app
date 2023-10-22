import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/base/no_data_page.dart';
import 'package:food_order_app/colors.dart';
import 'package:food_order_app/controllers/cart_controller.dart';
import 'package:food_order_app/controllers/popular_product_controller.dart';
import 'package:food_order_app/controllers/recommended_Product_controller.dart';
import 'package:food_order_app/dimensions.dart';
import 'package:food_order_app/pages/home/main_food_page.dart';
import 'package:food_order_app/widgets/app_icon.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:food_order_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../app_constant.dart';
import '../../route/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top:Dimensions.height20*3,
              left:Dimensions.width20,
              right:Dimensions.width20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[

                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize:Dimensions.iconSize24 ,
                      ),
                    ),
                    SizedBox(width: Dimensions.width20*5,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInitial());
                      },

                      child: AppIcon(icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize:Dimensions.iconSize24 ,
                      ),
                    ),
                    AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize:Dimensions.iconSize24 ,
                    )
                  ]
              )
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0? Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                    margin: EdgeInsets.only(top:Dimensions.height15),
                    color: Colors.white,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child:  GetBuilder<CartController>(builder: (CartController){
                        var _cartList = CartController.getItems;
                        return ListView.builder(
                            itemCount:_cartList.length,
                            // itemCount: CartController.getItems.length,
                            itemBuilder: (_,index){
                              return Container(
                                width: double.maxFinite,
                                height: Dimensions.height20*5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        var popularIndex = Get.find<PopularProductController>().
                                        popularProductList.
                                        indexOf(_cartList[index].product!);
                                        if(popularIndex>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));

                                        }else{
                                          var recommendedIndex = Get.find<RecommendProductController>().
                                          recommendedProductList.
                                          indexOf(_cartList[index].product!);
                                          // Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                          if(recommendedIndex<0){
                                            Get.snackbar("history product", "product review is not avalable for history product",
                                              backgroundColor: AppColors.mainColor,
                                              colorText: Colors.white,);

                                          }else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height20*5,
                                        height: Dimensions.height20*5,
                                        margin: EdgeInsets.only(bottom:Dimensions.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOAD_URI+CartController.getItems[index].img!
                                                )
                                            ),
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            color: Colors.white
                                        ),
                                      ) ,
                                    ),

                                    SizedBox(width: Dimensions.width10,),
                                    Expanded(child: Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: CartController.getItems[index].name!,color:Colors.black54,),
                                          //SmallText(text: "spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text:CartController.getItems[index].price.toString() , color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20,),
                                                    color: Colors.white
                                                ),
                                                child: Row(
                                                  children: [

                                                    GestureDetector(
                                                        onTap: () {
                                                          CartController.removeItem(_cartList[index].product!,1);
                                                          print(" being tapped here");
                                                        },
                                                        child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItems.toString(),),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    GestureDetector(
                                                        onTap: (){
                                                          CartController.addItem(_cartList[index].product!,1);
                                                          print("tapped here");
                                                        },

                                                        child: Icon(Icons.add, color: AppColors.signColor,))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            }
                        );
                      }),
                    )
                )
            ):NoDataPage(text: "your cart is empty");
          })

        ],
      ),
        bottomNavigationBar:GetBuilder<CartController>(builder: (CartController){
          return  Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left:Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                color:AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2) ,
                  topRight: Radius.circular(Dimensions.radius20*2) ,


                )
            ),
            child:  CartController.getItems.length>0?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20,),
                    color: Colors.white
                ),
                child: Row(
                  children: [

                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text:"\Rs " +CartController.totalAmount.toString(),),
                    SizedBox(width: Dimensions.width10/2,),

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  // popularProduct.addItem(product);
                  print("tapped");
                  CartController.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),

                  child: BigText(text:"\Rs| Check out", color:Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ):Container(),
          );
        },)
    );
  }
}
