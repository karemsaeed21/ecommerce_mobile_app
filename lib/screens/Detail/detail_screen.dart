import 'package:ecommerce_mobile_app/constants.dart';
import 'package:ecommerce_mobile_app/models/product_model.dart';
import 'package:ecommerce_mobile_app/screens/Detail/Widget/addto_cart.dart';
import 'package:ecommerce_mobile_app/screens/Detail/Widget/description.dart';
import 'package:ecommerce_mobile_app/screens/Detail/Widget/detail_app_bar.dart';
import 'package:ecommerce_mobile_app/screens/Detail/Widget/image_slider.dart';
import 'package:ecommerce_mobile_app/screens/Detail/Widget/items_details.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentImage = 0; // for the current image index which is 0
  int currentColor = 0; // for the current color index which is 0
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor, // for the background color of the detail screen
      // for add to cart , icon and quantity
      floatingActionButton: AddToCart(product: widget.product), // for the floating action button to add the product to the cart
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // to center the floating action button
      body: SafeArea(
          child: SingleChildScrollView( // to make the screen scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // for the alignment of the column to the start
          children: [
            // for back button share and favorite,
            DetailAppBar(product: widget.product,),
            // for detail image slider
            MyImageSlider(
              image: widget.product.image,
              onChange: (index) {
                setState(() {
                  currentImage = index;
                });
              },
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity, // for the width of the container to be the whole screen width
              decoration: const BoxDecoration(
                color: Colors.white, // for the color of the container
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // for product name, price, rating, and seller
                  ItemsDetails(product: widget.product),
                  const SizedBox(height: 20),
                  const Text(
                    "Color",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: List.generate(
                      widget.product.colors.length, // for the length of the colors
                      (index) => GestureDetector( // to click on the color to change the color of the product
                        onTap: () {
                          setState(() {
                            currentColor = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentColor == index
                                ? Colors.white
                                : widget.product.colors[index],
                            border: currentColor == index
                                ? Border.all(
                                    color: widget.product.colors[index],
                                  )
                                : null,
                          ),
                          padding: currentColor == index
                              ? const EdgeInsets.all(2)
                              : null,
                          margin: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: widget.product.colors[index],
                                shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ),
                  ),
                   const SizedBox(height: 25),
                   // for description
                   Description(description: widget.product.description,)
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
