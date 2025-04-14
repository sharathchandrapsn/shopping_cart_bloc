import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_bloc/Data/wishlist_data.dart';
import 'package:shopping_cart_bloc/wishlist/bloc/wishlist_event.dart';
import 'package:shopping_cart_bloc/wishlist/bloc/wishlist_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListLoadingState()) {
    on<WishListLoadingEvent>(wishListLoadingEvent);
    on<WishListRemoveItemEvent>(wishListRemoveItemEvent);
  }

  FutureOr<void> wishListLoadingEvent(
      WishListLoadingEvent event, Emitter<WishListState> emit) {
    emit(WishListSuccessState(wishList: wishList));
  }

  FutureOr<void> wishListRemoveItemEvent(
      WishListRemoveItemEvent event, Emitter<WishListState> emit) {
    wishList.remove(event.productModel);
    emit(WishListSuccessState(wishList: wishList));
    emit(WishListRemoveItemActionState());
  }
}
