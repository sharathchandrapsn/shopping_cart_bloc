import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_bloc/Cart/bloc/cart_event.dart';
import 'package:shopping_cart_bloc/Cart/bloc/cart_state.dart';
import 'package:shopping_cart_bloc/Data/cart_data.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState()) {
    on<CartLoadingEvent>(cartLoadingEvent);
    on<CartRemoveItemEvent>(cartRemoveItemEvent);
  }

  FutureOr<void> cartLoadingEvent(
      CartLoadingEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartList: cartList));
  }

  FutureOr<void> cartRemoveItemEvent(
      CartRemoveItemEvent event, Emitter<CartState> emit) {
    cartList.remove(event.productModel);
    emit(CartSuccessState(cartList: cartList));
    emit(CartRemoveItemActionState());
  }
}
