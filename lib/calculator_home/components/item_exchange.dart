import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../utils/applicationt.dart';
import '../controller/calculator_controller.dart';
import '../model/exchange_currency.dart';

class ItemExchange extends StatefulWidget {
  final ExchangeCurrencyType exchangeCurrencyType;

  const ItemExchange({Key? key, required this.exchangeCurrencyType}) : super(key: key);

  @override
  State<ItemExchange> createState() => _ItemExchangeState();
}

class _ItemExchangeState extends State<ItemExchange> {
  bool isPressed = false;
  final Color borderColorSelected = const Color.fromRGBO(46, 117, 255, 1);
  final Color bcgColorSelected = const Color.fromRGBO(237, 243, 255, 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap) {
        setState(() {
          isPressed = true;
        });
        Provider.of<CalculatorController>(Application.geralContext!, listen: false).changeMainCurrency(widget.exchangeCurrencyType);
        Navigator.pop(context);
      },
      onTapUp: (tap) {
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        padding: const EdgeInsets.only(left: 16, top: 19.5, bottom: 19.5),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isPressed ? bcgColorSelected : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: isPressed ? borderColorSelected : const Color.fromRGBO(249, 251, 255, 1))),
        child: Row(
          children: [
            SvgPicture.asset(ExchangeCurrency.getExchangeInfoFromID(widget.exchangeCurrencyType).icon,
                height: 31, semanticsLabel: 'A red up arrow'),
            const SizedBox(width: 16),
            Text(
              "${ExchangeCurrency.getExchangeInfoFromID(widget.exchangeCurrencyType).exchangeName},",
              style: TextStyle(
                  fontSize: 20,
                  color: isPressed ? borderColorSelected : Colors.black,
                  fontFamily: 'Urbanist-Light'),
            ),
            const SizedBox(width: 2),
            Text(
              ExchangeCurrency.getExchangeInfoFromID(widget.exchangeCurrencyType).exchangeSymbol,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(168, 168, 168, 1),
                  fontFamily: 'Urbanist-Light'),
            )
          ],
        ),
      ),
    );
  }
}