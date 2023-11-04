import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_task/core/cache/fav_product_cache.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/core/widgets/alert_ui.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class FavRepository {
  List<Product> favProducts = [];

  Future<List<Product>> getAllAllFavProducts() async {
    try {
      favProducts = CacheFavProducts.getFavProductList();
      return favProducts;
    } on Failure {
      rethrow;
    }
  }

  void addToFavList(Product product) {
    favProducts.add(product);
    _saveFavListInCache();
    AlertUI.showFlutterToast(msg: "add_to_fav".tr());
  }

  void _saveFavListInCache() {
    CacheFavProducts.saveCart(favProducts);
  }

  Future<void> removeFromCart(Product product) async {
    favProducts.removeWhere((element) => element.id == product.id);
    _saveFavListInCache();
    AlertUI.showFlutterToast(msg: "remove_from_fav".tr());
  }
}
