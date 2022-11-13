import 'package:flutter/material.dart';
import 'package:hns_calculator/calculator_home/components/character.dart';
import 'package:provider/provider.dart';

import '../components/number_row.dart';
import '../components/symbol.dart';
import '../controller/calculator_controller.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({Key? key}) : super(key: key);

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin:
          const EdgeInsets.only(left: 16, right: 16, top: 65, bottom: 65),
          child:

          MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (context) => CalculatorController()),
              ],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const NumberRowResult('assets/icons/hsn_money.svg', activeCalculator: true),
                  const SizedBox(height: 32),
                  const NumberRowResult('assets/icons/dolar_money.svg'),
                  Flexible(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          children:  <Widget>[
                            const CharacterCalculator(character: '7'),
                            const CharacterCalculator(character: '8'),
                            const CharacterCalculator(character: '9'),
                            SymbolCalculator(
                                symbolCalculatorCharacter: SymbolCalculatorCharacter.SWITCH),
                            const CharacterCalculator(character: '4'),
                            const CharacterCalculator(character: '5'),
                            const CharacterCalculator(character: '6'),
                            SymbolCalculator(
                                symbolCalculatorCharacter: SymbolCalculatorCharacter.PLUS),
                            const CharacterCalculator(character: '1'),
                            const CharacterCalculator(character: '2'),
                            const CharacterCalculator(character: '3'),
                            SymbolCalculator(
                                symbolCalculatorCharacter: SymbolCalculatorCharacter.MINUS),
                            const CharacterCalculator(character: '.'),
                            const CharacterCalculator(character: '0'),
                            SymbolCalculator(
                                symbolCalculatorCharacter: SymbolCalculatorCharacter.REMOVE),
                            SymbolCalculator(
                                symbolCalculatorCharacter: SymbolCalculatorCharacter.EQUAL),
                          ],
                        ),
                      ))
                ],
              ),
          ),


        ),
      ),
    );
  }
}
