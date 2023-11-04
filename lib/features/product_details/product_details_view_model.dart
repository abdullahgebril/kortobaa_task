import 'package:flutter/material.dart';
import 'package:flutter_task/core/exception/api_exception.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/core/widgets/alert_ui.dart';
import 'package:flutter_task/features/favoutites/model/fav_repository.dart';
import 'package:flutter_task/features/home/model/product_model.dart';
import 'package:flutter_task/features/product_details/model/product_repository.dart';

class ProductDetailsViewModel {
  ///objects
  ProductDetailsRepository repository = ProductDetailsRepository();
  GenericCubit<Product?> productDetailsCubit = GenericCubit(null);
  GenericCubit<bool> favProductCubit = GenericCubit(true);
  FavRepository favRepository = FavRepository();
  Product? product;
  List<Product> favProducts = [];

  /// methods
  Future getProductDetails(BuildContext context, id) async {
    productDetailsCubit.onLoadingState();

    try {
      final productResponse = await repository.getProductDetails(id);
      product = productResponse;
      checkProductinFavProducts(product!);
      productDetailsCubit.onUpdateData(product);
    } on ApiException catch (failure) {
      // show toast with error message
      if (context.mounted) {
        AlertUI.showAlert(
          context,
          message: failure.error,
          type: MessageType.error,
        );
      }

      productDetailsCubit.onErrorState(Failure(message: failure.error));
    }
  }

  void addFavProduct({required status, required Product product}) {
    favProductCubit.onLoadingState();
    product.isFavourite = !product.isFavourite;

    if (!product.isFavourite) {
      favRepository.removeFromCart(product);
    } else {
      favRepository.addToFavList(product);
    }
    favProductCubit.onUpdateData(!status);
  }
  // get fav product from cache

  Future<List<Product>> getFavProductList() async {
    List<Product> favProducts = await favRepository.getAllAllFavProducts();
    for (var element in favProducts) {
      element.isFavourite = true;
    }
    return favProducts;
  }

  Future<void> checkProductinFavProducts(Product product) async {
    List<Product> favProducts = await getFavProductList();
    for (var favProduct in favProducts) {
      if (favProduct.id == product.id) {
        product.isFavourite = true;
      }
    }
  }

  bool isProductInFavourites() {
    return product!.isFavourite ? true : false;
  }
}
