import 'package:flutter/material.dart';
import 'package:flutter_task/features/cart/cart_view_model.dart';
import 'package:flutter_task/features/cart/widget/cart_item.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key, required this.cartViewModel});

  final CartViewModel cartViewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cartViewModel.cartList.length,
        itemBuilder: (context, index) => CartItem(
              product: cartViewModel.cartList[index],
              cartViewModel: cartViewModel,
            ));
  }
}
