import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart_bloc/Models/product_model.dart';
import 'package:shopping_cart_bloc/wishlist/bloc/wishlist_bloc.dart';
import 'package:shopping_cart_bloc/wishlist/bloc/wishlist_event.dart';

class WishListItem extends StatelessWidget {
  const WishListItem({
    super.key,
    required this.productModel,
    required this.wishListBloc,
  });

  final ProductModel productModel;
  final WishListBloc wishListBloc;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if((imageUrl.isNotEmpty && Uri.tryParse(imageUrl)?.hasAbsolutePath == true)){}
            productModel.imageUrl.toString().isNotEmpty &&
                    Uri.tryParse(productModel.imageUrl.toString())!
                        .hasAbsolutePath
                ? SizedBox(
                    width: double.maxFinite,
                    child: CachedNetworkImage(
                      imageUrl: productModel.imageUrl.toString(),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  )
                : const Icon(
                    Icons.broken_image,
                    size: 300,
                  ),
            Container(
              height: 10,
            ),
            Text(
              productModel.name!,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              "\$${productModel.price!}",
              style: const TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    wishListBloc.add(
                        WishListRemoveItemEvent(productModel: productModel));
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
