import 'package:flutter_task/core/cache/cache_manger.dart';
import 'package:flutter_task/core/utils/app_constants.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class CacheFavProducts {
  static void saveCart(List<Product> products) {
    CacheManager.saveJson(AppConstants.favProductList, products);
  }

  static List<Product> getFavProductList() {
    final cacheCart = CacheManager.getJson(AppConstants.favProductList, []);
    List<Product> cartList = [];
    for (var cart in cacheCart) {
      cartList.add(Product.fromJson(cart));
    }
    return cartList;
  }
}
