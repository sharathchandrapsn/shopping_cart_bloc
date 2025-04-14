import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_bloc/Cart/ui/cart_screen.dart';
import 'package:shopping_cart_bloc/Home/bloc/home_bloc.dart';
import 'package:shopping_cart_bloc/Home/ui/product_item.dart';
import 'package:shopping_cart_bloc/repository/home_repository.dart';
import 'package:shopping_cart_bloc/service_locator.dart';
import 'package:shopping_cart_bloc/wishlist/ui/wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();
  final homeRepository = locator<HomeRepository>();

  @override
  void initState() {
    homeBloc.add(HomeLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartScreenActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        } else if (state is HomeNavigateToLikeScreenActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WishListScreen(),
            ),
          );
        } else if (state is HomeWishListedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Item wish-listed")));
        } else if (state is HomeCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Item carted")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "MESCP SHOPPING CART",
            ),
            actions: [
              IconButton(
                onPressed: () {
                  homeBloc.add(HomeLikeButtonClickedEvent());
                },
                icon: const Icon(
                  Icons.favorite_border_outlined,
                ),
              ),
              IconButton(
                onPressed: () {
                  homeBloc.add(HomeCartButtonClickedEvent());
                },
                icon: const Icon(
                  Icons.shopping_basket_outlined,
                ),
              ),
            ],
          ),
          body: productList(state, homeBloc),
        );
      },
    );
  }
}

Widget productList(Object? state, HomeBloc homeBloc) {
  switch (state.runtimeType) {
    case HomeLoadingState:
      return const Center(child: CircularProgressIndicator());
    case HomeSuccessState:
      final successState = state as HomeSuccessState;
      return ListView.builder(
          itemCount: successState.productList.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductItem(
              productModel: successState.productList[index],
              homeBloc: homeBloc,
            );
          });
    case HomeFailureState:
      return const Center(child: Text("Error Occured"));
    default:
      return const SizedBox();
  }
}
