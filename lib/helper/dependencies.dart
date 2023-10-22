import 'package:food_order_app/Data/api/api_client.dart';
import 'package:food_order_app/Data/repository/auth_repo.dart';
import 'package:food_order_app/Data/repository/popular_product_repo.dart';
import 'package:food_order_app/controllers/popular_product_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/repository/cart_repo.dart';
import '../Data/repository/recommend_product_repo.dart';
import '../app_constant.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/recommended_Product_controller.dart';

Future<void> init() async {
  final sharedPreferences =  await SharedPreferences.getInstance();

  Get.lazyPut(()=> sharedPreferences);

  // Create and initialize api client
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL, token: AppConstants.TOKEN));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // Create and initialize repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  // Create and initialize controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
