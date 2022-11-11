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
    return SizedBox(
      height: 78,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // hsn_money.svg
          Row(children: [
            SvgPicture.asset(widget.icon,
                height: 30,
                color: Colors.blue,
                semanticsLabel: 'A red up arrow'),
            const SizedBox(width: 6),
            const Text(
              'HNS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            )
          ]),
          widget.activeCalculator
              ? Consumer<CalculatorController>(
                  builder: (context, calculator, child) {
                    textEditingController.text = calculator.numberString;
                    return Expanded(
                        child: AutoSizeTextField(
                      controller: textEditingController,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 64, color: Colors.black),
                      maxLines: 1,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.all(20)),
                    ));
                  },
                )
              : Expanded(
                  child: AutoSizeTextField(
                  controller: textEditingController,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 64, color: Colors.black),
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
