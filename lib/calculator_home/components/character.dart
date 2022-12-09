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

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, right: 12),
      height: 80,
      child: GestureDetector(
        onTapDown: (tap) {
          Provider.of<CalculatorController>(context, listen: false)
              .addStringCharater(widget.character);
          setState(() {
            isPressed = true;
          });
        },
        onTapCancel: (){
          setState(() {
            isPressed = false;
          });
        },
        onTapUp: (tap) {
          setState(() {
            isPressed = false;
          });
        },
        child: Container(
          key: Key(widget.character),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPressed ? colorOver : colorNormal,
              ),
          child: Center(
            child: Text(
              widget.character,
              style: TextStyle(
                  fontSize: 32,
                  color: isPressed ? colorNormal : Colors.black ,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Urbanist-Regular'),
            ),
          ),
        ),
      ),
    );
  }
}
