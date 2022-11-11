import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/calculator_controller.dart';

class CharacterCalculator extends StatefulWidget {
  final String character;

  const CharacterCalculator({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterCalculator> createState() => _CharacterCalculatorState();
}

class _CharacterCalculatorState extends State<CharacterCalculator> {
  final Color colorNormal = const Color.fromRGBO(249, 251, 255, 1);
  final Color colorOver = const Color.fromRGBO(46, 117, 255, 1);

  bool hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, right: 12),
      height: 80,
      child: OutlinedButton(
        onPressed: () {
          Provider.of<CalculatorController>(context, listen: false)
              .addStringCharater(widget.character);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return colorOver;
            }
            return colorNormal;
          }),
          backgroundColor:  MaterialStateProperty.resolveWith<Color>((states) {
            return colorNormal;
          }),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
            return const CircleBorder(side: BorderSide.none);
          }),
          side: MaterialStateProperty.resolveWith((states) {
            return BorderSide.none;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return Colors.black;
          }),
        ),
        child: Text(
          widget.character,
          style: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
