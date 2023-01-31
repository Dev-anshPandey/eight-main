import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CatgProvider extends ChangeNotifier {
  int catgIndex = 0;
  void setCatgIndex(int id) {
    catgIndex = id;
    notifyListeners();
  }
}
