import 'package:flutter_task/core/cache/cache_manger.dart';
import 'package:flutter_task/core/utils/app_constants.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class CartCache {
  static void saveProductProviderId(int productProviderId) {}

  static void saveCart(List<Product> products) {
    CacheManager.saveJson(AppConstants.cartList, products);
  }

  static List<Product> getCart() {
    final cacheCart = CacheManager.getJson(AppConstants.cartList, []);
    List<Product> cartList = [];
    for (var cart in cacheCart) {
      cartList.add(Product.fromJson(cart));
    }
    return cartList;
  }
}
