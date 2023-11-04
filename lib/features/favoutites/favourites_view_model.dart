import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/features/favoutites/model/fav_repository.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class FavouritesViewModel {
  FavRepository favRepository = FavRepository();
  GenericCubit<bool> favProductCubit = GenericCubit(true);
  List<Product> favProducts = [];

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
  Future getFavProductList() async {
    favProductCubit.onLoadingState();
    try {
      favProducts = await favRepository.getAllAllFavProducts();
      for (var element in favProducts) {
        element.isFavourite = true;
      }
      favProductCubit.onUpdateData(true);
    } on Failure catch (failure) {
      favProductCubit.onErrorState(Failure(message: failure.data['message']));
    }
  }
}
