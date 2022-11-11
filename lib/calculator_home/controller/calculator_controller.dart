import 'dart:ffi';

import 'package:flutter/material.dart';

class CalculatorController extends ChangeNotifier{
  String numberString = '';
  double numberDouble = 0.0;


  void addStringCharater(String character){
    numberString+=character;
    notifyListeners();
  }

  void remove(){
    numberString = numberString.substring(0, numberString.length - 1);
    notifyListeners();
  }

  void addOperation(){

  }

}