import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/pages/home/main_food_page.dart';
import 'package:food_order_app/route/route_helper.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_Product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}):super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
   await Get.find<PopularProductController>().getPopularProductList();
   await  Get.find<RecommendProductController>().getRecommendedProductList();
  }
  @override
  void initState(){

    super.initState();
    _loadResource();
    controller =  AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2))..forward();
    animation=  CurvedAnimation(
        parent: controller,
        curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
        ()=>Get.offNamed(RouteHelper.getInitial())
      //     () {
      //   Get.toNamed(RouteHelper.getInitial()); // Replace NextPage with the actual page you want to navigate to.
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
              child: Center(child: Image.asset("assets/images/logo1.jpeg",width: 250,))),
          Center(child: Image.asset("assets/images/logo.png",width: 250,))
        ],
      )
    );
  }
}

