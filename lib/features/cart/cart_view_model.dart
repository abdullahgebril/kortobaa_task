import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/core/cache/cart_cache.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/core/widgets/alert_ui.dart';
import 'package:flutter_task/features/cart/model/cart_repository.dart';
import 'package:flutter_task/features/cart/model/shop_cart_event.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class CartViewModel {
  // Objects
  List<Product> _cartProducts = [];
  GenericCubit<bool> cartCubit = GenericCubit(true);
  CartRepository repository = CartRepository();
  // Variables

  double amount = 0.0;
  List<Product> get cartList => _cartProducts;

  Future getAllProductsInCart() async {
    cartCubit.onLoadingState();
    try {
      amount = 0.0;
      _cartProducts = await repository.getAllAllCartProducts();
      for (var product in _cartProducts) {
        double price = double.parse(product.price);
        amount = amount + price * product.cartRequestedQuantity;
      }
      cartCubit.onUpdateData(true);
      ShopCartCountEvent.sentCountEvent(_cartProducts.length);
    } on Failure catch (failure) {
      cartCubit.onErrorState(Failure(message: failure.data['message']));
    }
  }

  void addToCart(status, Product product) {
    //cartCubit.onLoadingState();
    double price = double.parse(product.price);
    amount = amount + price * product.cartRequestedQuantity;

    _addToCart(product);
    cartCubit.onUpdateData(!status);
  }

  void _addToCart(Product product) {
    if (isExistInCart(product)) {
      AlertUI.showFlutterToast(msg: "already_added".tr());
      return;
    }
    product.isAddedToCart = !product.isAddedToCart;
    _cartProducts.add(product);
    _saveCartInCache();
    ShopCartCountEvent.sentCountEvent(_cartProducts.length);

    AlertUI.showFlutterToast(msg: "add_to_cart".tr());
  }

  Future<void> removeFromCart(int index) async {
    cartCubit.onLoadingState();
    double price = double.parse(_cartProducts[index].price);
    amount = amount - price * _cartProducts[index].cartRequestedQuantity;
    _cartProducts.removeAt(index);
    _saveCartInCache();
    ShopCartCountEvent.sentCountEvent(_cartProducts.length);
    AlertUI.showFlutterToast(msg: "remove_from_cart".tr());
    cartCubit.onUpdateData(true);
  }

  void _saveCartInCache() {
    CartCache.saveCart(_cartProducts);
  }

  bool isExistInCart(Product product) {
    for (int index = 0; index < cartList.length; index++) {
      if (_cartProducts[index].id == product.id) {
        return true;
      }
    }
    return false;
  }

  int getRequestedPurchaseQuantity(Product product) {
    for (int index = 0; index < cartList.length; index++) {
      if (_cartProducts[index].id == product.id) {
        return _cartProducts[index].cartRequestedQuantity;
      }
    }
    return 1;
  }

  void increaseRequestedPurchaseQuantity(
      Product product, int increaseByQuantity) {
    cartCubit.onLoadingState();
    double price = double.parse(product.price);
    // check if user can increase quantity
    /*
    if (productData.cartRequestedQuantity + increaseByQuantity >
        productData.quantity) {
      // reach max.
      showFlutterToast(msg: "out_of_stock".tr());
      return;
    }
    */
    // if can increase by increaseByQuantity
    product.cartRequestedQuantity += increaseByQuantity;
    amount += price;
    AlertUI.showFlutterToast(msg: "quantity_increase_from_cart".tr());
    if (!isExistInCart(product)) {
      _cartProducts.add(product);
    }
    _saveCartInCache();
    cartCubit.onUpdateData(true);
  }

  void decreaseRequestedPurchaseQuantity(
      Product product, int decreaseByQuantity) {
    cartCubit.onLoadingState();
    double price = double.parse(product.price);
    // check if can reach zero.
    if (product.cartRequestedQuantity - decreaseByQuantity <= 0) {
      AlertUI.showFlutterToast(msg: "reach_min".tr());
      return;
    }
    // decrease
    product.cartRequestedQuantity -= decreaseByQuantity;
    amount -= price;

    AlertUI.showFlutterToast(msg: "quantity_decreased_from_cart".tr());
    if (!isExistInCart(product)) {
      _cartProducts.add(product);
    }
    _saveCartInCache();
    cartCubit.onUpdateData(true);
  }

  Future<void> setProuductQountity(
      dynamic status, Product product, String qountityText) async {
    cartCubit.onLoadingState();
    amount = 0.0;
    int qountity = int.parse(qountityText);
    product.cartRequestedQuantity = qountity;
    double price = double.parse(product.price);
    amount += qountity * price;
    cartCubit.onUpdateData(!status);
  }

  double getProductAmount(Product product) {
    double price = double.parse(product.price);
    return price * product.cartRequestedQuantity;
  }

  int getProductIndex(Product product) {
    return _cartProducts.indexOf(product);
  }

  void askDeleteProductFromCart(BuildContext context, Product product) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertUI.askToDeleteItem(context,
            deletePressed: () => removeFromCart(getProductIndex(product))
                .then((value) => Navigator.pop(context))));
  }
}
