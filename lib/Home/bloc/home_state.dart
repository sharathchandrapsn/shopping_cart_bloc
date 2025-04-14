part of 'home_bloc.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ProductModel> productList;

  HomeSuccessState(this.productList);
}

class HomeFailureState extends HomeState {}

class HomeNavigateToLikeScreenActionState extends HomeActionState {}

class HomeNavigateToCartScreenActionState extends HomeActionState {}

class HomeCartedActionState extends HomeActionState {}

class HomeWishListedActionState extends HomeActionState {}
