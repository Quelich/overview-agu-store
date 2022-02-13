import 'package:flutter/cupertino.dart';
import '../helpers/db_helper.dart';
import 'dart:developer' as dev;


class CartItem {
  final String id;
  final String title;
  final String price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];


  List<CartItem> get items {
    return [..._items];
  }


  int getTotalPrice()  {
    int result = 0;
    for (var item in _items) {
      result += int.parse(item.price);
    }
    dev.log("Performing total price calculation: " + result.toString());
    return result;
  }

  Future<void> fetchAndSetItems() async {
    final dataList = await DBHelper.getData('cart_items');

    _items = dataList
        .map(
          (item) => CartItem(
        id: item['id'],
        title: item['title'],
        price: item['price'],
        imageUrl: item['imageUrl'],
      ),
    )
        .toList();
    notifyListeners();
  }
}
