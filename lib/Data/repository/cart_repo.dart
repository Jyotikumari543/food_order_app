import 'dart:convert';
import 'package:food_order_app/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

 CartRepo({required this.sharedPreferences});
List<String> cart=[];
List<String> cartHistory=[];

 Future<void> addToCartList(List<CartModel> cartList) async {

  // sharedPreferences.remove(AppConstants.CART_LIST);
  // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  var time= DateTime.now().toString();
cartList.forEach((element) {
 element.time = time;
 return cart.add(jsonEncode(element));
});

  try {

   final cart = cartList.map((element) => jsonEncode(element)).toList();
  cartList.forEach((element) =>cart.add(jsonEncode(element)));
   await sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
   print(sharedPreferences.getStringList(AppConstants.CART_LIST));
   getCartList();
  } catch (e) {
   print("Error: $e");
  }
 }

 List<CartModel>getCartList(){
  List<String> carts=[];
  if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
   carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
  // print("inside getCartList "+carts.toString());
  }
  List<CartModel> cartList=[];

  carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))) ) ;


  return cartList;
 }

 List<CartModel> getCartHistoryList(){
  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
   cartHistory=[];
   cartHistory= sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
  }
  List<CartModel> cartListHistory=[];
  cartHistory.forEach((element)=> cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
  return cartListHistory;
 }
 void addToCartHistoryList(){
  List<String> cart= sharedPreferences.getStringList(AppConstants.CART_LIST) ?? [];
  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
   cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
  }
  for(int i =0;i<cart.length;i++){
   print("history list "+cart[i]);
   cartHistory.add(cart[i]);
  }
  removeCart();
  sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  print("The length of history list is "+getCartHistoryList().length.toString());
  List<CartModel> cartHistoryList = getCartHistoryList();
  for (int j = 0; j < cartHistoryList.length; j++) {
   print("Order time for order $j is " + cartHistoryList[j].time.toString());
  }
 }
 void removeCart(){
  cart=[];
  sharedPreferences.remove(AppConstants.CART_LIST);
 }
}
