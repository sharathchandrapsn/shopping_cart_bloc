import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_bloc/Data/cart_data.dart';
import 'package:shopping_cart_bloc/Data/wishlist_data.dart';
import 'package:shopping_cart_bloc/Models/product_model.dart';
import 'package:shopping_cart_bloc/Data/home_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeLoadingEvent>(homeLoadingEvent);
    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);
    on<HomeLikeButtonClickedEvent>(homeLikeButtonClickedEvent);
    on<HomeItemCartButtonClickedEvent>(homeItemCartButtonClickedEvent);
    on<HomeItemLikeButtonClickedEvent>(homeItemLikeButtonClickedEvent);
  }

  FutureOr<void> homeLoadingEvent(
      HomeLoadingEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    try {
      emit(HomeSuccessState(HomeRepository()
          .cartItems
          .map((e) => ProductModel(
              itemId: e['itemId'],
              name: e['name'],
              quantity: e['quantity'],
              price: e['price'],
              imageUrl: e['imageUrl']))
          .toList()));
    } catch (e) {
      emit(HomeFailureState());
    }
  }

  FutureOr<void> homeCartButtonClickedEvent(
      HomeCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("home cart button clicked");
    emit(HomeNavigateToCartScreenActionState());
  }

  FutureOr<void> homeLikeButtonClickedEvent(
      HomeLikeButtonClickedEvent event, Emitter<HomeState> emit) {
    print("home like button clicked");
    emit(HomeNavigateToLikeScreenActionState());
  }

  FutureOr<void> homeItemCartButtonClickedEvent(
      HomeItemCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("home item cart button clicked");
    cartList.add(event.productModel);
    emit(HomeCartedActionState());
  }

  FutureOr<void> homeItemLikeButtonClickedEvent(
      HomeItemLikeButtonClickedEvent event, Emitter<HomeState> emit) {
    print("home item like button clicked");
    wishList.add(event.productModel);
    emit(HomeWishListedActionState());
  }
}
