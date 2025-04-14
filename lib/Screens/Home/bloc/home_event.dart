part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomeLikeButtonClickedEvent extends HomeEvent {}

class HomeCartButtonClickedEvent extends HomeEvent {}

class HomeItemLikeButtonClickedEvent extends HomeEvent {
  final ProductModel productModel;

  HomeItemLikeButtonClickedEvent({required this.productModel});
}

class HomeItemCartButtonClickedEvent extends HomeEvent {
  final ProductModel productModel;

  HomeItemCartButtonClickedEvent({required this.productModel});
}
