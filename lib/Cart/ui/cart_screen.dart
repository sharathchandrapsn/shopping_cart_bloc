import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_bloc/Cart/bloc/cart_bloc.dart';
import 'package:shopping_cart_bloc/Cart/bloc/cart_event.dart';
import 'package:shopping_cart_bloc/Cart/bloc/cart_state.dart';
import 'package:shopping_cart_bloc/Cart/ui/cart_item.dart';
import 'package:shopping_cart_bloc/Home/ui/product_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MESCP SHOPPING CART",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // homeBloc.add(HomeLikeButtonClickedEvent());
            },
            icon: const Icon(
              Icons.favorite_border_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              // homeBloc.add(HomeCartButtonClickedEvent());
            },
            icon: const Icon(
              Icons.shopping_basket_outlined,
            ),
          ),
        ],
      ),
      body: BlocConsumer(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartRemoveItemActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("cart item removed"),
              ),
            );
          }
        },
        builder: (context, state) {
          return productList(state, cartBloc);
        },
      ),
    );
  }

  Widget productList(Object? state, CartBloc cartBloc) {
    switch (state.runtimeType) {
      case CartLoadingState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case CartSuccessState:
        var successState = state as CartSuccessState;
        return ListView.builder(
            itemCount: successState.cartList.length,
            itemBuilder: (context, index) {
              return CartItem(
                productModel: successState.cartList[index],
                cartBloc: cartBloc,
              );
            });
      default:
        return const SizedBox();
    }
  }
}
