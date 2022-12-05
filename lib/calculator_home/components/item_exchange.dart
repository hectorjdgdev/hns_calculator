import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ItemExchange extends StatelessWidget {
  final String icon;
  final String exchangeName;
  final String exchangeSymbol;

  const ItemExchange(
      {Key? key,
      required this.icon,
      required this.exchangeName,
      required this.exchangeSymbol})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16, bottom: 8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: const Color.fromRGBO(249, 251, 255, 1)
        )
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 19.5, bottom: 19.5),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 31, semanticsLabel: 'A red up arrow'),
            const SizedBox(width: 16),
            Text(
              exchangeName,
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: 'Urbanist-Light'),
            ),
            const SizedBox(width: 2),
            Text(
              exchangeSymbol,
              style: const TextStyle(
                  fontSize: 20, color: Color.fromRGBO(168, 168, 168, 1), fontFamily: 'Urbanist-Light'),
            )
          ],
        ),
      ),
    );
  }
}
