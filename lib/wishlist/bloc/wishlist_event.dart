import 'package:shopping_cart_bloc/Models/product_model.dart';

abstract class WishListEvent {}

class WishListLoadingEvent extends WishListEvent {}

class WishListCartButtonClickedEvent extends WishListEvent {
  final ProductModel productModel;

  WishListCartButtonClickedEvent({required this.productModel});
}

class WishListRemoveItemEvent extends WishListEvent {
  final ProductModel productModel;

  WishListRemoveItemEvent({required this.productModel});
}
