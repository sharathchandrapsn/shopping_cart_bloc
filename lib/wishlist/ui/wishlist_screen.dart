import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_bloc/wishlist/bloc/wishlist_bloc.dart';
import 'package:shopping_cart_bloc/wishlist/bloc/wishlist_event.dart';
import 'package:shopping_cart_bloc/wishlist/bloc/wishlist_state.dart';
import 'package:shopping_cart_bloc/wishlist/ui/wish_list_item.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  WishListBloc wishListBloc = WishListBloc();

  @override
  void initState() {
    wishListBloc.add(WishListLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WishList Screen"),
      ),
      body: BlocConsumer(
          bloc: wishListBloc,
          listenWhen: (previous, current) => current is WishListActionState,
          buildWhen: (previous, current) => current is! WishListActionState,
          listener: (context, state) {
            if (state is WishListRemoveItemActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("removed wish-list item"),
                ),
              );
            }
          },
          builder: (context, state) {
            return wishListItem(state, wishListBloc);
          }),
    );
  }

  Widget wishListItem(Object? state, WishListBloc wishListBloc) {
    switch (state.runtimeType) {
      case WishListLoadingState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case WishListSuccessState:
        var successState = state as WishListSuccessState;
        return ListView.builder(
            itemCount: successState.wishList.length,
            itemBuilder: (context, index) {
              return WishListItem(
                  productModel: successState.wishList[index],
                  wishListBloc: wishListBloc);
            });
      default:
        return const SizedBox();
    }
  }
}
