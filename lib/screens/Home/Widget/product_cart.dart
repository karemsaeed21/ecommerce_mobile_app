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
      child: Stack(
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
                const SizedBox(height: 5), // for the space between the image and the top of the card
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
                const SizedBox(height: 10), // for the space between the image and the title
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
                const SizedBox(height: 10), // for the space between the title and the price
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "\$${product.price}", // for the price of the product
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // for the bold of the price
                      fontSize: 17, // for the font size of the price
                    ),
                  ),
                ),
                const SizedBox(height: 5), // for the space between the price and the rate
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Rate: ${product.rate}", // for the rate of the product
                    style: const TextStyle(
                      fontSize: 14,  // for the font size of the rate
                      color: Colors.black45, // for the color of the rate
                    ),
                  ),
                ),
                const SizedBox(height: 10), // for the space between the rate and the colors
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: List.generate(
                      product.colors.length, // for the number of colors
                      (index) => Container(
                        width: 18, // for the width of the color
                        height: 18, // for the height of the color
                        margin: const EdgeInsets.only(right: 4), // for the margin between the colors
                        decoration: BoxDecoration(
                          color: product.colors[index], // for the color of the color
                          shape: BoxShape.circle, // for the shape of the color
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10), // for the space between the colors and the sizes
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: GestureDetector( // to click on the favorite icon to add the product to the favorite list
                  onTap: () {
                    provider.toggleFavorite(product);
                  },
                  child: Icon( // for the favorite icon
                    provider.isExist(product)
                        ? Icons.favorite
                        : Icons.favorite_border, // for the icon of the favorite
                    color: Colors.white, // for the color of the favorite icon
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