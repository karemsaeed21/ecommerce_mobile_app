import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorite = []; // for the list of the favorite products that i clicked on the favorite icon
  List<Product> get favorites => _favorite; // for the getter of the favorite products list to get the list of the favorite products
  void toggleFavorite(Product product) {
    if (_favorite.contains(product)) {
      _favorite.remove(product); // if the product is already in the favorite list then remove it
    } else {
      _favorite.add(product); // if the product is not in the favorite list then add it
    }
    notifyListeners(); // to notify the listeners
  }

  bool isExist(Product product) {
    final isExist = _favorite.contains(product);
    return isExist; // to check if the product is already in the favorite list or not to filled the favorite icon with the color
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
