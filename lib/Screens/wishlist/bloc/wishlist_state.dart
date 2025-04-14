import 'package:shopping_cart_bloc/Models/product_model.dart';

abstract class WishListState {}

class WishListActionState extends WishListState {}

class WishListLoadingState extends WishListState {}

class WishListSuccessState extends WishListState {
  final List<ProductModel> wishList;

  WishListSuccessState({required this.wishList});
}

class WishListRemoveItemActionState extends WishListActionState {}
