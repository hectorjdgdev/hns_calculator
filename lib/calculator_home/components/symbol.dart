import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../controller/calculator_controller.dart';



class PairSymbolCalculator {
  final String symbolName;
  final Color symbolColor;

  const PairSymbolCalculator(
      {required this.symbolName, required this.symbolColor});
}

class SymbolCalculator extends StatefulWidget {
  final SymbolCalculatorCharacter symbolCalculatorCharacter;

  const SymbolCalculator({Key? key, required this.symbolCalculatorCharacter})
      : super(key: key);

  @override
  State<SymbolCalculator> createState() => _SymbolCalculatorState();
}

class _SymbolCalculatorState extends State<SymbolCalculator> {
  final Map<SymbolCalculatorCharacter, PairSymbolCalculator> mapSymbols =
      <SymbolCalculatorCharacter, PairSymbolCalculator>{
    SymbolCalculatorCharacter.EQUAL: const PairSymbolCalculator(
        symbolName: 'assets/icons/equal_icon.svg',
        symbolColor: Color.fromRGBO(158, 165, 178, 1)),
    SymbolCalculatorCharacter.SWITCH: const PairSymbolCalculator(
        symbolName: 'assets/icons/switch_icon.svg',
        symbolColor: Color.fromRGBO(46, 117, 255, 1)),
    SymbolCalculatorCharacter.MINUS: const PairSymbolCalculator(
        symbolName: 'assets/icons/minus_icon.svg',
        symbolColor: Color.fromRGBO(246, 29, 29, 1)),
    SymbolCalculatorCharacter.PLUS: const PairSymbolCalculator(
        symbolName: 'assets/icons/plus_icon.svg',
        symbolColor: Color.fromRGBO(5, 165, 12, 1)),
    SymbolCalculatorCharacter.REMOVE: const PairSymbolCalculator(
        symbolName: 'assets/icons/remove_icon.svg', symbolColor: Colors.black)
  };

  final Color colorNormal = const Color.fromRGBO(249, 251, 255, 1);

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (event) {
        setState(() {
          pressed = false;
        });
      },
      onPointerDown: (event) {
        setState(() {
          pressed = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12, right: 12),
        height: 80,
        child: OutlinedButton(
          onPressed: () {
            switch (widget.symbolCalculatorCharacter) {
              case SymbolCalculatorCharacter.REMOVE:
                {
                  Provider.of<CalculatorController>(context, listen: false)
                      .remove();
                }
                break;
              case SymbolCalculatorCharacter.SWITCH:
                {

                }
                break;
              case SymbolCalculatorCharacter.EQUAL:{
                Provider.of<CalculatorController>(context, listen: false)
                    .equalOperation();
              }
              break;
              case SymbolCalculatorCharacter.MINUS:
              case SymbolCalculatorCharacter.PLUS:{
                Provider.of<CalculatorController>(context, listen: false)
                    .clickMathOperation(widget.symbolCalculatorCharacter);
              }
              break;
            }

          },
          onLongPress: () {
            switch (widget.symbolCalculatorCharacter) {
              case SymbolCalculatorCharacter.REMOVE:
                {
                  Provider.of<CalculatorController>(context, listen: false)
                      .removeAll();
                  HapticFeedback.mediumImpact();
                }
            }
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.pressed)) {
                return mapSymbols[widget.symbolCalculatorCharacter]!
                    .symbolColor;
              }
              return colorNormal;
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
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
              return mapSymbols[widget.symbolCalculatorCharacter]!.symbolColor;
            }),
          ),
          child: Center(
            child: pressed
                ? SvgPicture.asset(
                    mapSymbols[widget.symbolCalculatorCharacter]!.symbolName,
                    height: 32,
                    width: 32,
                    color: Colors.white,
                    semanticsLabel: 'A red up arrow')
                : SvgPicture.asset(
                    mapSymbols[widget.symbolCalculatorCharacter]!.symbolName,
                    height: 32,
                    width: 32,
                    semanticsLabel: 'A red up arrow'),
          ),
        ),
      ),
    );
  }
}
