import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/controllers/cart_controller.dart';
import 'package:food_order_app/controllers/popular_product_controller.dart';
import 'package:food_order_app/pages/auth/sign_in_pages.dart';
import 'package:food_order_app/pages/cart/cart_pages.dart';
import 'package:food_order_app/pages/food/popular_food_detail.dart';
import 'package:food_order_app/pages/food/recommended_food_detail.dart';
import 'package:food_order_app/pages/home/food_page_body.dart';
import 'package:food_order_app/pages/home/main_food_page.dart';
import 'package:food_order_app/pages/home/main_food_page.dart';
import 'package:food_order_app/pages/splash/splash_page.dart';
import 'package:food_order_app/route/route_helper.dart';
import 'package:get/get.dart' ;
import 'controllers/recommended_Product_controller.dart';
import 'helper/dependencies.dart' as dep;
 Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
Get.find<CartController>().getCartData();

  return  GetBuilder<PopularProductController>(builder:(_){
      return GetBuilder<RecommendProductController>(builder:(_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          //home: SignInPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });

  }
}

