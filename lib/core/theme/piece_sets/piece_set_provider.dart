import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'piece_set.dart';

class PieceSetProvider with ChangeNotifier {
  PieceSet _currentSet = PieceSet.getAllSets()[0];

  PieceSet get currentSet => _currentSet;

  void setSet(PieceSet set) {
    _currentSet = set;
    notifyListeners();
  }
}
