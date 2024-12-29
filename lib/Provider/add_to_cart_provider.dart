import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;
  void toogleCart(Product product) {
    final index = _cart.indexWhere((element) => element.title == product.title); // Check if the product is already in the cart if it is, return the index of the product if not return -1
    if (index != -1) {
      _cart[index].quantity++; // If the product is already in the cart, increment the quantity of the product
    } else {
      _cart.add(product); // If the product is not in the cart, add the product to the cart
    }
    notifyListeners(); // Notify the listeners
  } // Add a product to the cart

// for increment
  incrementQtn(int index) {
    _cart[index].quantity++;
    notifyListeners();
  } // Increment the quantity of a product

  // for decrement
  decrementQtn(int index) {
    if (_cart[index].quantity <= 1) {
    } else {
      _cart[index].quantity--;
    }
    notifyListeners();
    totalPrice(); // Update the total price
  } // Decrement the quantity of a product

  void clearCart() {
    _cart.clear();
    notifyListeners();
  } // Clear the cart

  // for total amount
  totalPrice() {
    double myTotal = 0.0; // initial
    for (Product element in _cart) {
      myTotal += element.price * element.quantity;
    }
    return myTotal;
  } // Calculate the total price of the products in the cart

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}