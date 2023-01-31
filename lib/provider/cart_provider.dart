import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<Widget> cartItems = [];
  void addCI(Widget widgett) {
    cartItems.add(widgett);
    notifyListeners();
  }

  void deleteCI(int id) {
    cartItems.removeAt(id);
    notifyListeners();
  }
}
