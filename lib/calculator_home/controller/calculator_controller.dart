import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../model/exchange_currency.dart';
import 'conversion_api.dart';

enum SymbolCalculatorCharacter {
  REMOVE,
  EQUAL,
  PLUS,
  MINUS,
  SWITCH,
  NONE,
  NUMBER,
  POINT
}

class CalculatorController extends ChangeNotifier {
  String numberStringVisual = "0";
  String secondaryStringVisual = "0";
  String mathOperation = "";
  bool isFirstOperation = true;
  SymbolCalculatorCharacter isLastNumberOperation =
      SymbolCalculatorCharacter.NONE;

  ExchangeCurrencyType selectedMainCurrency = ExchangeCurrencyType.HNS;
  ExchangeCurrencyType selectedSecondaryCurrency = ExchangeCurrencyType.USD;

  void addStringCharater(String character) {
    if (!(character == "." &&
        isLastNumberOperation == SymbolCalculatorCharacter.POINT)) {
      if (((numberStringVisual == "0") && (numberStringVisual != ".")) ||
          (isLastNumberOperation != SymbolCalculatorCharacter.NUMBER)) {
        if (isLastNumberOperation == SymbolCalculatorCharacter.POINT) {
          numberStringVisual += character;
        } else {
          numberStringVisual = character;
        }
      } else {
        numberStringVisual += character;
      }

      if (character == ".") {
        isLastNumberOperation = SymbolCalculatorCharacter.POINT;
      } else {
        isLastNumberOperation = SymbolCalculatorCharacter.NUMBER;
      }
      changeOperation();
    }
  }

  void remove() {
    if (numberStringVisual.isNotEmpty) {
      if (numberStringVisual.length == 1) {
        numberStringVisual = "0";
      } else {
        numberStringVisual =
            numberStringVisual.substring(0, numberStringVisual.length - 1);
      }
      changeOperation();
      notifyListeners();
    }
  }

  void removeAll() {
    numberStringVisual = '0';
    mathOperation = "";
    isFirstOperation = true;
    isLastNumberOperation = SymbolCalculatorCharacter.NONE;
    secondaryStringVisual = "0";
    notifyListeners();
  }

  void clickMathOperation(SymbolCalculatorCharacter operation) {
    if (isLastNumberOperation != operation) {
      if (isLastNumberOperation == SymbolCalculatorCharacter.NUMBER) {
        equalOperation();
      }
      isFirstOperation = false;
      switch (operation) {
        case SymbolCalculatorCharacter.MINUS:
          {
            mathOperation = "$numberStringVisual-";
          }
          break;
        case SymbolCalculatorCharacter.PLUS:
          {
            mathOperation = "$numberStringVisual+";
          }
          break;
      }
      if (numberStringVisual == "0") {
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
    changeOperation();
    notifyListeners();
  }

  void changeMainCurrency(ExchangeCurrencyType newMainCurrency) {
    if (newMainCurrency != selectedSecondaryCurrency &&
        newMainCurrency != selectedMainCurrency) {
      selectedMainCurrency = newMainCurrency;
      changeOperation();
    }
  }

  void switchCurrency() {
    ExchangeCurrencyType temp = selectedMainCurrency;
    selectedMainCurrency = selectedSecondaryCurrency;
    selectedSecondaryCurrency = temp;
    String tempString = numberStringVisual;
    numberStringVisual = secondaryStringVisual;
    secondaryStringVisual = tempString;
    changeOperation();
  }

  Future<void> changeOperation() async {
    var rate = await ConversionApi.getConversionRate(
        selectedMainCurrency, selectedSecondaryCurrency);
    secondaryStringVisual =
        (double.parse(numberStringVisual) * rate).toStringAsFixed(4);
    notifyListeners();
  }
}
