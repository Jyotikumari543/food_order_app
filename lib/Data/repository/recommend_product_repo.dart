import 'package:food_order_app/Data/api/api_client.dart';
import 'package:food_order_app/app_constant.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});
  Future<Response>getRecommendedProductList() async{


    //return await apiClient.getData( AppConstants.RECOMMENDED_PRODUCT_URI, AppConstants.TOKEN);
    return await apiClient.getData( AppConstants.RECOMMENDED_PRODUCT_URI,);

  }
}