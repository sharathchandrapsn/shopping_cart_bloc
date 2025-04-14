import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart_bloc/Models/product_model.dart';
import 'package:shopping_cart_bloc/Screens/Home/bloc/home_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productModel,
    required this.homeBloc,
  });

  final ProductModel productModel;
  final HomeBloc homeBloc;

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
                    homeBloc.add(HomeItemLikeButtonClickedEvent(
                        productModel: productModel));
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomeItemCartButtonClickedEvent(
                        productModel: productModel));
                  },
                  icon: const Icon(
                    Icons.shopping_basket_outlined,
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
