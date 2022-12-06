import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hns_calculator/common/ui/RectangularButton.dart';
import 'package:provider/provider.dart';

import '../controller/calculator_controller.dart';
import 'item_exchange.dart';

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
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 580 / MediaQuery.of(context).size.height,
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
                    Column(
                      children: const [
                        ItemExchange(
                          icon: 'assets/icons/hns_icon_light.svg',
                          exchangeName: 'Handshake,',
                          exchangeSymbol: 'HNS',
                        ),
                        ItemExchange(
                          icon: 'assets/icons/btc_icon_light.svg',
                          exchangeName: 'Bitcoin,',
                          exchangeSymbol: 'BTC',
                        ),
                        ItemExchange(
                          icon: 'assets/icons/usd_icon_light.svg',
                          exchangeName: 'US Dollar,',
                          exchangeSymbol: 'USD',
                        ),
                        ItemExchange(
                          icon: 'assets/icons/eur_icon_light.svg',
                          exchangeName: 'Euro,',
                          exchangeSymbol: 'EUR',
                        ),
                        ItemExchange(
                          icon: 'assets/icons/gbp_icon_light.svg',
                          exchangeName: 'British Pound Sterling,',
                          exchangeSymbol: 'GBP',
                        ),
                       RectangularButton()
                      ],
                    )
                  ],
                ),
              );
            });
      },
      child: SizedBox(
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
                      textEditingController.text =
                          calculator.numberStringVisual;
                      return Expanded(
                          child: AutoSizeTextField(
                        enabled: false,
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
                    enabled: false,
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
      ),
    );
  }
}
