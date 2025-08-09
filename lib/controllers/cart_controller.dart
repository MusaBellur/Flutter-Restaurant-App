import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:restaurants_app/data/repository/cart_repo.dart';
import 'package:restaurants_app/models/cart_model.dart';
import 'package:restaurants_app/models/product_model.dart';
import 'package:restaurants_app/utils/colors.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items={};

  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.id)){
      _items.update(product.id!, (value) {
        totalQuantity = (value.quantity ?? 0) + quantity;


        if (totalQuantity <= 0) {
        _items.remove(product.id!); // Kartı sil.
        _items = Map.from(_items); // Referansı sıfırla.
        print("Kart silindi: ${product.name}, Kalan öğeler: ${_items.keys}");
        update(); // UI'yi güncelle.
      }

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: (value.quantity ?? 0) + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );

        
      });
    }
    else{
      if(quantity > 0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );}
        );
      }
      else{
        Get.snackbar("Uyarı!", "En az bir sipariş eklemelisiniz!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white
        );
      }
      
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
      return false;
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
     _items.forEach((key, value) {
       if(key == product.id){
        quantity = value.quantity != null ? value.quantity! : 0;
       }
     });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity != null ? value.quantity! : 0;
      print("TotalQuentity = "+ totalQuantity.toString());
    },);
    return totalQuantity;
  }

  List<CartModel>get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{
    int total = 0;
    _items.forEach((key, value) {
      total += (value.price ?? 0) * (value.quantity ?? 0);

    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> item){
    storageItems = item;
    print("Cart Sayısı: "+ storageItems.length.toString());
    for (var i = 0; i < storageItems.length; i++) {
      if (storageItems[i].product != null) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    } else {
      print("Warning: Product is null for cart item at index $i");
    }
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items={};
    update();
  }

  
}