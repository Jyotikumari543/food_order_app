import 'package:food_order_app/Data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../Data/repository/recommend_product_repo.dart';
import '../models/product_models.dart';


class RecommendProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded=> _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    // print("API Response status code: ${response.statusCode}");
    // print("API Response body: ${response.body}");

    if (response.statusCode == 200) {
      print("Got products recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products!);
      // print("Product list: $_popularProductList");
      _isLoaded=true;
      update();
    } else {
      print("Failed to fetch recommended products. Status code: ${response.statusCode}");
    }
  }

}
