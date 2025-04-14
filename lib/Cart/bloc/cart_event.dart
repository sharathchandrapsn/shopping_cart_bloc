import 'package:shopping_cart_bloc/Cart/ui/cart_item.dart';
import 'package:shopping_cart_bloc/Models/product_model.dart';

abstract class CartEvent {}

class CartLoadingEvent extends CartEvent {}

class CartRemoveItemEvent extends CartEvent {
  final ProductModel productModel;

  CartRemoveItemEvent({required this.productModel});
}
