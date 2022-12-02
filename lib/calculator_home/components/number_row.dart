import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../controller/calculator_controller.dart';

class NumberRowResult extends StatefulWidget {
  final String icon;
  final bool activeCalculator;

  const NumberRowResult(this.icon, {Key? key, this.activeCalculator = false})
      : super(key: key);

  @override
  State<NumberRowResult> createState() => _NumberRowResultState();
}

class _NumberRowResultState extends State<NumberRowResult> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color colorText = widget.activeCalculator
        ? Colors.black
        : const Color.fromRGBO(158, 165, 178, 1);
    return SizedBox(
      height: 78,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // hsn_money.svg
          Center(
            child: Row(children: [
              SizedBox(
                width: 88,
                child: SvgPicture.asset(widget.icon,
                    color: colorText,
                    height: 26,
                    semanticsLabel: 'A red up arrow'),
              ),
            ]),
          ),
          widget.activeCalculator
              ? Consumer<CalculatorController>(
                  builder: (context, calculator, child) {
                    textEditingController.text = calculator.numberStringVisual;
                    return Expanded(
                        child: AutoSizeTextField(
                      controller: textEditingController,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontSize: 64,
                          color: Colors.black,
                          fontFamily: 'Urbanist-Light'),
                      maxLines: 1,
                      showCursor: true,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 0)),
                    ));
                  },
                )
              : Expanded(
                  child: AutoSizeTextField(
                  controller: textEditingController,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 64,
                      color: Colors.black,
                      fontFamily: 'Urbanist-Light'),
                  maxLines: 1,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.all(20)),
                ))
        ],
      ),
    );
  }
}
