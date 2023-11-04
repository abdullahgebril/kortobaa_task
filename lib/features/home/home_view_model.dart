import 'package:flutter/material.dart';
import 'package:flutter_task/core/exception/api_exception.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/core/utils/color_resources.dart';
import 'package:flutter_task/core/utils/image_resources.dart';
import 'package:flutter_task/core/widgets/alert_ui.dart';
import 'package:flutter_task/features/cart/model/cart_repository.dart';
import 'package:flutter_task/features/favoutites/model/fav_repository.dart';
import 'package:flutter_task/features/home/model/category.dart';
import 'package:flutter_task/features/home/model/home_repository.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class HomeViewmodel {
  ///objects
  GenericCubit<bool> bannerCubit = GenericCubit(true);
  GenericCubit<bool> favProductCubit = GenericCubit(true);
  GenericCubit<CategoryModel?> categoriesCubit = GenericCubit(null);
  GenericCubit<ProductModel?> recentProductsCubit = GenericCubit(null);
  GenericCubit<ProductModel?> mostPopularProductsCubit = GenericCubit(null);
  HomeRepository homeRepository = HomeRepository();
  CartRepository repository = CartRepository();
  FavRepository favRepository = FavRepository();

  ///variables
  int bannerIndex = 0;
  Color dropFliterColor = ColorResources.orangeColor;
  List<Category> categories = [];
  List<Product> recentProducts = [];
  List<Product> mostPopular = [];

  List<Product> localCartProductsList = [];

  ///methods

  List<String> banners = [
    ImageResources.firstBanner,
    ImageResources.secondBanner
  ];

  Future<void> getCategories(BuildContext context) async {
    categoriesCubit.onLoadingState();

    try {
      final categoriesResponse = await homeRepository.getCategories();
      categories = categoriesResponse.categories;

      categoriesCubit.onUpdateData(categoriesResponse);
    } on ApiException catch (failure) {
      // show toast with error message
      if (context.mounted) {
        AlertUI.showAlert(
          context,
          message: failure.error,
          type: MessageType.error,
        );
      }

      categoriesCubit.onErrorState(Failure(message: failure.error));
    }
  }

  Future<void> getRecentProducts(BuildContext context) async {
    recentProductsCubit.onLoadingState();

    try {
      final productsResponse = await homeRepository.getRecentProducts();
      recentProducts = productsResponse.products;
      checkProductinFavProducts(recentProducts);
      checkProductinCart(recentProducts);
      recentProductsCubit.onUpdateData(productsResponse);
    } on ApiException catch (failure) {
      // show toast with error message
      if (context.mounted) {
        AlertUI.showAlert(
          context,
          message: failure.error,
          type: MessageType.error,
        );
      }

      recentProductsCubit.onErrorState(Failure(message: failure.error));
    }
  }

  Future<void> getMostPopularProducts(BuildContext context) async {
    mostPopularProductsCubit.onLoadingState();

    try {
      final productsResponse = await homeRepository.getMostPopularProducts();
      mostPopular = productsResponse.products;
      checkProductinFavProducts(mostPopular);
      checkProductinCart(mostPopular);
      mostPopularProductsCubit.onUpdateData(productsResponse);
    } on ApiException catch (failure) {
      // show toast with error message
      if (context.mounted) {
        AlertUI.showAlert(
          context,
          message: failure.error,
          type: MessageType.error,
        );
      }

      mostPopularProductsCubit.onErrorState(Failure(message: failure.error));
    }
  }

  void addFavProduct({required status, required Product product}) {
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
    final favProducts = await favRepository.getAllAllFavProducts();
    for (var element in favProducts) {
      element.isFavourite = true;
    }
    return favProducts;
  }

  /// check products is favourites or not
  Future<void> checkProductinFavProducts(List<Product> products) async {
    List<Product> favProducts = await getFavProductList();
    for (var product in products) {
      for (var favProduct in favProducts) {
        if (favProduct.id == product.id) {
          product.isFavourite = true;
        }
      }
    }
  }

  /// check products is favourites or not
  Future<void> checkProductinCart(List<Product> products) async {
    localCartProductsList = await repository.getAllAllCartProducts();
    for (var product in products) {
      for (var productItem in localCartProductsList) {
        if (productItem.id == product.id) {
          product.isAddedToCart = true;
        }
      }
    }
  }

  void setBannerIndex(int index) {
    bannerCubit.onUpdateToInitState(false);
    bannerIndex = index;
    dropFliterColor =
        index == 0 ? ColorResources.orangeColor : ColorResources.primaryColor;
    bannerCubit.onUpdateData(true);
  }
}
