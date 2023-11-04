import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/models/failure.dart';
import 'package:flutter_task/features/cart/model/cart_repository.dart';
import 'package:flutter_task/features/cart/model/shop_cart_event.dart';
import 'package:flutter_task/features/home/model/product_model.dart';

class BottomNavBarViewModel {
  CartRepository repository = CartRepository();
  int selectedIndex = 0;
  List<Product>? localCartProductsList;
  GenericCubit<dynamic> bottomNavBarCubit = GenericCubit(null);

  changePage(int index) {
    bottomNavBarCubit.onLoadingState();
    try {
      selectedIndex = index;
      bottomNavBarCubit.onUpdateData(index);
    } on Failure catch (failure) {
      bottomNavBarCubit.onErrorState(Failure(message: failure.data['message']));
    }
  }

  Future getAllProductsInCart() async {
    bottomNavBarCubit.onLoadingState();
    try {
      localCartProductsList = await repository.getAllAllCartProducts();

      bottomNavBarCubit.onUpdateData(localCartProductsList);
      ShopCartCountEvent.sentCountEvent(localCartProductsList!.length);
    } on Failure catch (failure) {
      bottomNavBarCubit.onErrorState(Failure(message: failure.data['message']));
    }
  }
}
