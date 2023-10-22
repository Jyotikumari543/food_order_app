import 'package:flutter/material.dart';
import 'package:food_order_app/models/product_models.dart';
import 'package:get/get.dart';

import '../Data/repository/cart_repo.dart';
import '../colors.dart';
import '../models/Cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  List<CartModel> storageItems = [];
    late Map<int, CartModel> _item = {};

  Map<int, CartModel> get item => _item;

  void addItem(ProductModel product, int quantity) {
    if (quantity > 0) {
      if (_item.containsKey(product.id!)) {
        // If the product is already in the cart, update its quantity
        _item.update(product.id!, (value) {
          return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: value.product, // Use the existing product
          );
        });
      } else {
        // If the product is not in the cart, add it
        _item[product.id!] = CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      }
    } else {
      Get.snackbar(
        "Item Count",
        "You should add at least one item to the cart",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  void removeItem(ProductModel product, int quantityToRemove) {
    if (_item.containsKey(product.id)) {
      _item.update(product.id!, (value) {
        final newQuantity = value.quantity! - quantityToRemove;
        if (newQuantity > 0) {
          // If the new quantity is greater than zero, update it
          return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: newQuantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: value.product,
          );
        } else {
          // If the new quantity is zero or negative, remove the item from the cart
          return value;
        }
      });

      // Remove the item from the cart if quantity is zero or negative
      if (_item[product.id!] == null) {
        _item.remove(product.id!);
      }
      cartRepo.addToCartList(getItems);
      update(); // Notify listeners of the change
    }
  }


  bool existInCart(ProductModel product) {
    return _item.containsKey(product.id);
  }

  int getQuantity(ProductModel product) {
    if (_item.containsKey(product.id)) {
      return _item[product.id]!.quantity!;
    }
    return 0;
  }

  int get totalItems {
    int totalQuantity = 0;
    _item.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _item.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _item.forEach((key, value) {
      if (value.quantity != null && value.price != null) {
        total += value.quantity! * value.price!;
      }
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("Length of cart items"+storageItems.length.toString());

    for (int i = 0; i < storageItems.length; i++) {
      _item.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }
  void clear() {
   _item.clear();
    //_item={};
    update();
  }
  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  void setItems(Map<int, CartModel> setItems) {
    _item = {}; // Clear the existing map
    _item = setItems; // Assign the new map
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

}