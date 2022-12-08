import 'dart:ffi';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hns_calculator/calculator_home/model/exchange_currency.dart';
import 'package:hns_calculator/common/ui/RectangularButton.dart';
import 'package:provider/provider.dart';

import '../../utils/applicationt.dart';
import '../controller/calculator_controller.dart';
import 'item_exchange.dart';

class NumberRowResult extends StatefulWidget {
  final bool activeCalculator;


  const NumberRowResult({Key? key, this.activeCalculator = false})
      : super(key: key);

  @override
  State<NumberRowResult> createState() => _NumberRowResultState();
}

class _NumberRowResultState extends State<NumberRowResult> {
  TextEditingController textEditingController = TextEditingController();
  bool isPressed = false;
  Color colorSelected = const Color.fromRGBO(46, 117, 255, 1);
  final List<Widget> arrayOfExchanges = ExchangeCurrency.mapSymbols.entries
      .map<Widget>((value) => ItemExchange(
    exchangeCurrencyType: value.key,
  ))
      .toList();

  @override
  Widget build(BuildContext context) {
    Color colorText = widget.activeCalculator
        ? Colors.black
        : const Color.fromRGBO(158, 165, 178, 1);

    return GestureDetector(
      onTapDown:  widget.activeCalculator ? (tap) {
        setState(() {
          isPressed = true;
        });
      }: null,
      onTapUp:  widget.activeCalculator ? (tap) {
        setState(() {
          isPressed = false;
        });
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            builder: (context) {
              Application.geralContext = context;
              return FractionallySizedBox(
                heightFactor: 500 / MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(188, 188, 188, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    const Center(
                      child: Text(
                        "Choose Currency",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Urbanist'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Column(
                        children: arrayOfExchanges,
                      ),
                    )
                  ],
                ),
              );
            });
      } : null,
      child: Container(
        height: 78,
        width: MediaQuery.of(context).size.width-32,
        color: isPressed ? Color.fromRGBO(249, 251, 255, 1) : Colors.white,
        child: Consumer<CalculatorController>(
                builder: (context, calculator, child) {
                  textEditingController.text = widget.activeCalculator ? calculator.numberStringVisual : calculator.secondaryStringVisual;
                  ExchangeCurrencyType currencyType = widget.activeCalculator ? calculator.selectedMainCurrency : calculator.selectedSecondaryCurrency;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Row(children: [
                          SizedBox(
                            width: 88,
                            child: SvgPicture.asset(ExchangeCurrency.getExchangeInfoFromID(currencyType).symbolCalculator,
                                color: isPressed ? colorSelected : colorText,
                                height: 26,
                                semanticsLabel: 'A red up arrow'),
                          ),
                        ]),
                      ),
                      Expanded(
                          child: AutoSizeTextField(
                        enabled: false,
                        controller: textEditingController,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 64,
                            color:  widget.activeCalculator ? isPressed ? colorSelected : Colors.black :  colorText,
                            fontFamily: 'Urbanist-Light'),
                        maxLines: 1,
                        showCursor: true,
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 0)),
                      )),
                    ],
                  );
                },
              )
      ),
    );
  }
}
