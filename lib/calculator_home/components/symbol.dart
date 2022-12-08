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
  final Function? callable;

  const SymbolCalculator({Key? key,this.callable, required this.symbolCalculatorCharacter})
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

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, right: 12),
      height: 80,
      child: GestureDetector(
        onTapDown: (tap) {
          switch (widget.symbolCalculatorCharacter) {
            case SymbolCalculatorCharacter.REMOVE:
              {
                Provider.of<CalculatorController>(context, listen: false)
                    .remove();
              }
              break;
            case SymbolCalculatorCharacter.SWITCH:
              {
                Provider.of<CalculatorController>(context, listen: false).switchCurrency();
                widget.callable!();
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
          setState(() {
            isPressed = true;
          });
        },
        onTapUp: (tap){
          setState(() {
            isPressed = false;
          });
        },
        onLongPressStart: (tap) {
          switch (widget.symbolCalculatorCharacter) {
            case SymbolCalculatorCharacter.REMOVE:
              {
                Provider.of<CalculatorController>(context, listen: false)
                    .removeAll();
                HapticFeedback.mediumImpact();
              }
          }
          setState(() {
            isPressed = true;
          });
        },
        onLongPressEnd: (tap){
          setState(() {
            isPressed = false;
          });
        },
        child: Container(
          key: Key(widget.symbolCalculatorCharacter.name),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPressed ? mapSymbols[widget.symbolCalculatorCharacter]!
                .symbolColor : colorNormal,
          ),
          child: Center(
            child: isPressed
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
