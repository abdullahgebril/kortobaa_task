import 'package:flutter_task/core/network/api_manager.dart';
import 'package:flutter_task/features/home/model/category.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class HomeRepository {
  Future<CategoryModel> getCategories() async {
    final response = await ApiManager.sendRequest(
      link: 'api/v1/categories',
      method: Method.GET,
    );
    return CategoryModel.fromJson(response!.data!);
  }

  Future<ProductModel> getRecentProducts() async {
    final response = await ApiManager.sendRequest(
      link: 'api/v1/products/category/5',
      method: Method.GET,
    );
    return ProductModel.fromJson(response!.data!);
  }

  Future<ProductModel> getMostPopularProducts() async {
    final response = await ApiManager.sendRequest(
      link: 'api/v1/products/category/1',
      method: Method.GET,
    );
    return ProductModel.fromJson(response!.data!);
  }
}
