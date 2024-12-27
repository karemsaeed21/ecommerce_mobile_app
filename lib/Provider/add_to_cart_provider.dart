import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;
  void toogleFavorite(Product product) {
    final index = _cart.indexWhere((element) => element.title == product.title);
    if (index != -1) {
      _cart[index].quantity++;
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

// for increment
  incrementQtn(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  // for decrement
  decrementQtn(int index) {
    if (_cart[index].quantity <= 1) {
    } else {
      _cart[index].quantity--;
    }
    notifyListeners();
    totalPrice(); // Update the total price
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // for total amount
  totalPrice() {
    double myTotal = 0.0; // initial
    for (Product element in _cart) {
      myTotal += element.price * element.quantity;
    }
    return myTotal;
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}