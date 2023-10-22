import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_order_app/colors.dart';
import 'package:food_order_app/controllers/cart_controller.dart';
import 'package:food_order_app/Data/repository/popular_product_repo.dart';
import '../models/Cart_model.dart';
import '../models/product_models.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  late CartController cart;

  Future<void> getPopularProductList() async {
    try {
      final response = await popularProductRepo.getPopularProductList();
      if (response.statusCode == 200) {
        final productData = Product.fromJson(response.body);
        if (productData.products != null) {
          _popularProductList = List<ProductModel>.from(productData.products!);
          _isLoaded = true;
          update();
        }
      } else {
        print("Failed to fetch products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("number of items "+_quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems+quantity) < 0) {
      Get.snackbar(
        "Item Count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity=-_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems+quantity) > 20) {
      Get.snackbar(
        "Item Count",
        "You can't add more than 20 items",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cartController;
    var exist=_cart.existInCart(product);
    print("exist or not "+exist.toString());
    if(exist){
       _inCartItems=_cart.getQuantity(product);
    }
    print("the quantity in the cart is "+_inCartItems.toString());
  }

  void addItem(ProductModel product) {
   // if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);
      _cart.item.forEach((key, value) {
        print("the id is ${value.id} the quantity is ${value.quantity}");
      });

    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }

}