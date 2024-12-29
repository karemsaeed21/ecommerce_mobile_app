import 'package:ecommerce_mobile_app/Provider/favorite_provider.dart';
import 'package:ecommerce_mobile_app/constants.dart';
import 'package:ecommerce_mobile_app/models/product_model.dart';
import 'package:ecommerce_mobile_app/screens/Detail/detail_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return GestureDetector( // to click on the item to navigate to the detail screen
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product),
          ),
        );
      },
      child: Stack( // for the stack of the card item and the favorite icon on the top right of the card item
        children: [
          Container(
            width: double.infinity, // for the width of the container to be the whole screen width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // the border radius for each card item
              color: kcontentColor, // the color of the card item
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //
              children: [
                const SizedBox(height: 10), // for the space between the image and the top of the card
                Center( // for the centering of the image
                  child: Hero(
                    tag: product.image, // to get the image from the product model
                    child: Image.asset(
                      product.image,
                      width: 150, // for the width of the image
                      height: 150, // for the height of the image
                      fit: BoxFit.cover, // for the image fit
                    ),
                  ),
                ),
                const SizedBox(height: 5), // for the space between the image and the title
                Padding(
                  padding: const EdgeInsets.only(left: 10), // for the left padding of the title
                  child: Text(
                    product.title, // for the title of the product
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // for the bold of the title
                      fontSize: 16, // for the font size of the title
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${product.description.substring(0, 60)}...", // for the rate of the product
                    style: const TextStyle(
                      fontSize: 13,  // for the font size of the rate
                      color: Colors.black45, // for the color of the rate
                    ),
                  ),
                ),
                const SizedBox(height: 15), // for the space between the title and the price
                Padding(
                  padding: const EdgeInsets.only(left: 10 , right: 15), // for the padding of the price
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // for space between first and second text
                    children: [
                      Text(
                        "\$${product.price}", // for the price of the product
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, // for the bold of the price
                          fontSize: 17, // for the font size of the price
                        ),
                      ),
                    Row(
                    children: [
                    Icon( // for the icon of the rate
                      Icons.star, // for the icon of the rate
                      color: Colors.yellow[700], // for the color of the rate
                      size: 20, // for the size of the rate
                    ),
                    Text(
                      "${product.rate}", // for the rating of the product
                      style: const TextStyle(
                        fontSize: 15, // for the font size of the rating
                        color: Colors.black,
                        fontWeight: FontWeight.bold,// for the color of the rating
                      ),
                    ),
                  ],
                ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned( // Favorite icon position
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: GestureDetector( // to click on the favorite icon to add the product to the favorite list
                  onTap: () {
                    provider.toggleFavorite(product);
                  },
                  child: Icon( // for the favorite icon
                    provider.isExist(product)
                        ? Icons.favorite
                        : Icons.favorite_border, // for the icon of the favorite
                    color: kprimaryColor, // for the color of the favorite icon
                    size: 22, // for the size of the favorite icon
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}