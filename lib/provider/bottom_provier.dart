import 'package:flutter/cupertino.dart';

class BottomProvider extends ChangeNotifier {
  int bottomNo = 1;
  void setBottomNo(int no) {
    bottomNo = no;
    notifyListeners();
  }
}
