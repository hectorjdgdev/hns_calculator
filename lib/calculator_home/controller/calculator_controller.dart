import 'dart:ffi';

import 'package:flutter/material.dart';

class CalculatorController extends ChangeNotifier {
  String numberString = '';
  double numberDouble = 0.0;

  void addStringCharater(String character) {
    if (numberString == '0') {
      numberString = character;
    } else {
      numberString += character;
    }

    notifyListeners();
  }

  void remove() {
    if (numberString.isNotEmpty) {
      numberString = numberString.substring(0, numberString.length - 1);
      notifyListeners();
    }
  }

  void removeAll() {
    numberString = '0';
    notifyListeners();
  }

  void addOperation() {}
}
