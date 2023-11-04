import 'package:flutter_task/core/cache/cart_cache.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class CartRepository {
  Future<List<Product>> getAllAllCartProducts() async {
    try {
      return CartCache.getCart();
    } on Failure {
      rethrow;
    }
  }
}
