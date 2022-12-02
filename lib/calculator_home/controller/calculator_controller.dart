import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

enum SymbolCalculatorCharacter { REMOVE, EQUAL, PLUS, MINUS, SWITCH, NONE, NUMBER, POINT }



class CalculatorController extends ChangeNotifier {
  String numberStringVisual = "0";
  String mathOperation = "";
  bool isFirstOperation = true;
  SymbolCalculatorCharacter isLastNumberOperation = SymbolCalculatorCharacter.NONE;



  void addStringCharater(String character) {
    if (((numberStringVisual == "0")  && (numberStringVisual != ".")) || (isLastNumberOperation != SymbolCalculatorCharacter.NUMBER))  {
      numberStringVisual = character;
    } else {
      numberStringVisual += character;
    }
    isLastNumberOperation = SymbolCalculatorCharacter.NUMBER;
    notifyListeners();
  }

  void remove() {
    if (numberStringVisual.isNotEmpty) {
      if(numberStringVisual.length == 1){
        numberStringVisual = "0";
      }else{
        numberStringVisual = numberStringVisual.substring(0, numberStringVisual.length - 1);
      }
      notifyListeners();
    }
  }


  void removeAll() {
    numberStringVisual = '0';
    mathOperation = "";
    isFirstOperation = true;
    isLastNumberOperation = SymbolCalculatorCharacter.NONE;
    notifyListeners();
  }

  void clickMathOperation(SymbolCalculatorCharacter operation) {
    if(isLastNumberOperation != operation){
      if(isLastNumberOperation == SymbolCalculatorCharacter.NUMBER){
        equalOperation();
      }
      isFirstOperation = false;
      switch (operation) {
        case SymbolCalculatorCharacter.MINUS:
          {
            mathOperation = "$numberStringVisual-";
          }
          break;
        case SymbolCalculatorCharacter.PLUS: {
          mathOperation = "$numberStringVisual+";
        }
        break;
      }
      if(numberStringVisual == "0"){
        numberStringVisual = "0";
      }
      notifyListeners();
    }
    isLastNumberOperation = operation;

  }

  void equalOperation() {
    // double numberPrev = double.tryParse(prevNumber)!;
    // double numberActual = double.tryParse(numberStringVisual)!;
    mathOperation += numberStringVisual;
    double result = 0;
    Parser p = Parser();
    Expression exp = p.parse(mathOperation);
    ContextModel cm = ContextModel();
    result = exp.evaluate(EvaluationType.REAL, cm);
    numberStringVisual = result.toString();
    mathOperation = "";
    notifyListeners();

  }
}
