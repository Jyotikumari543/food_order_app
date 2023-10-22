import 'package:food_order_app/Data/api/api_client.dart';
import 'package:food_order_app/app_constant.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});
  Future<Response>getPopularProductList() async{


      //return await apiClient.getData( AppConstants.POPULAR_PRODUCT_URI, AppConstants.TOKEN);
      return await apiClient.getData( AppConstants.POPULAR_PRODUCT_URI,);

  }
}