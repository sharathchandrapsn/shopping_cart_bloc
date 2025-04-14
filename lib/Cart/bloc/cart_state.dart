import 'package:shopping_cart_bloc/Models/product_model.dart';

abstract class CartState {}

class CartActionState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductModel> cartList;

  CartSuccessState({required this.cartList});
}

class CartRemoveItemActionState extends CartActionState {}
