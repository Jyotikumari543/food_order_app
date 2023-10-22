import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/app_constant.dart';
import 'package:food_order_app/controllers/popular_product_controller.dart';
import 'package:food_order_app/dimensions.dart';
import 'package:food_order_app/pages/cart/cart_pages.dart';
import 'package:food_order_app/route/route_helper.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../colors.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_Product_controller.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/extendable_text_widget.dart';
import '../home/main_food_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
 final  int pageId;
 final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<RecommendProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }

                    },
                    child: AppIcon(iconColor:AppColors.mainColor,icon: Icons.clear)),
             //   AppIcon(iconColor:AppColors.mainColor,icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap:(){
                      if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:0,top:0,


                            child: AppIcon(icon: Icons.circle , size: 20,iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,),

                        )
                            :Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:3,top:3,
                          child:BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                            size:12,color: Colors.black ,
                          ),
                        ):Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
            bottom: PreferredSize(

              preferredSize: Size.fromHeight(20),
              child: Container(

                //margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10,),
                color: Colors.white,
                child: Center(child: BigText(size: Dimensions.font26,text:product.name!,),),
                width: double.maxFinite,
                padding: EdgeInsets.only(top:5,bottom:10 ),
              /*  decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight:Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)
                  ),
                  color: Colors.white,
                ),*/


              ),

            ),
            pinned:true,
            backgroundColor: AppColors.yelloColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                 AppConstants.BASE_URL+AppConstants.UPLOAD_URI+product.img!,
                width:double.maxFinite,
                fit: BoxFit.cover,
              ),


            ),
          ),
          SliverToBoxAdapter(

            child: ExtendableTextWidget( text:product.description!),
           // margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
          )

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (Controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left:Dimensions.width20*2.5,
                right:Dimensions.width20*2.5,
                top:Dimensions.height10,
                bottom:Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24
                        ,iconColor:Colors.white,
                        backgroundColor:AppColors.mainColor,
                        icon:Icons.remove),
                  ),
                  BigText(text: "\Rs ${product.price!} X ${Controller.inCartItems}",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                  GestureDetector(
                    onTap: (){
                     Controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24
                        ,iconColor:Colors.white,
                        backgroundColor:AppColors.mainColor,
                        icon:Icons.add),
                  ),

                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left:Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                  color:AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2) ,
                    topRight: Radius.circular(Dimensions.radius20*2) ,


                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20,),
                        color: Colors.white
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Controller.addItem(product);
                    },
                    child:Container(
                      padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
                      child: BigText(text:"\Rs ${product.price!}| Add to cart", color:Colors.white),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ) ,
                  )

                ],
              ),
            ),
          ],
        );
      },),

    );
  }
}
