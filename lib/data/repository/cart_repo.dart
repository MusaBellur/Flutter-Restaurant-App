import 'dart:convert';

import 'package:restaurants_app/models/cart_model.dart';
import 'package:restaurants_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[];

  void addToCartList(List<CartModel> cartList){

    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    cart=[];
    cartList.forEach((element)=> cart.add(jsonEncode(element)));

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("Cart List: ${carts.toString()}");
    }
    List<CartModel> cartList = [];
    
    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) => cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));

    return cartHistoryList;
  }

  void addToCartHistoryList(){

    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for (var i = 0; i < cart.length; i++) {
      print("Geçmiş: ${cart[i]}");
      cartHistory.add(cart[i]);
    }

    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("Geçmiş Listesi Uzunluğu: ${getCartHistoryList().length.toString()}");
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

}