import 'package:ecommerce_mobile_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_mobile_app/screens/Cart/checkout_process_screen.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _discountController = TextEditingController();
  double _discount = 0.0;

  void _applyDiscount() {
    if (_discountController.text == 'DIS50') {
      setState(() {
        _discount = 0.5;
      });
    } else {
      setState(() {
        _discount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context); // Provider instance
    final finalList = provider.cart; // Cart list from provider instance
    producrQuantity(IconData icon, int index) { // iconData that take which icon is clicked , index is the index of which the product is clicked
      return GestureDetector(
        onTap: () {
          setState(() {
            icon == Icons.add // if icon is add then increment the quantity else decrement the quantity
                ? provider.incrementQtn(index)
                : provider.decrementQtn(index);
          });
        },
        child: Icon(
          icon,
          size: 20,
        ),
      );
    }

    double totalPrice = provider.totalPrice() * (1 - _discount);

    return Scaffold(
      backgroundColor: kcontentColor, // Background color
      appBar: AppBar( // Appbar
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: kcontentColor, // Background color
        elevation: 0, // No shadow
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: finalList.length,
                itemBuilder: (context, index) {
                  final cartItems = finalList[index];
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kcontentColor,
                                ),
                                child: Image.asset(cartItems.image),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItems.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    cartItems.category,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey.shade400),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "\$${cartItems.price}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 35,
                        right: 35,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                finalList.removeAt(index);
                                provider.totalPrice(); // Update the total price
                                provider.notifyListeners(); // Notify listeners to trigger a rebuild
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: kprimaryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kcontentColor,
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  producrQuantity(Icons.add, index),
                                  const SizedBox(width: 10),
                                  Text(
                                    cartItems.quantity.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  producrQuantity(Icons.remove, index),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: _discountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      filled: true,
                      fillColor: kcontentColor,
                      hintText: "Enter Discount Code",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      suffixIcon: TextButton(
                        onPressed: _applyDiscount,
                        child: const Text(
                          "Apply",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kprimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "SubTotal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$${provider.totalPrice()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider.cart.isEmpty ? Colors.grey : kprimaryColor,
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    onPressed: provider.cart.isEmpty
                        ? null
                        : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CheckoutProcessScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Check Out",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}