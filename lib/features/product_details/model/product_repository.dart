import 'package:flutter_task/core/network/api_manager.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class ProductDetailsRepository {
  Future getProductDetails(id) async {
    final response = await ApiManager.sendRequest(
      link: 'api/v1/products/$id/',
      method: Method.GET,
    );
    return Product.fromJson(response!.data!);
  }
}
