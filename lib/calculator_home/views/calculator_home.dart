import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hns_calculator/calculator_home/components/character.dart';
import 'package:provider/provider.dart';

import '../../utils/applicationt.dart';
import '../components/number_row.dart';
import '../components/symbol.dart';
import '../controller/calculator_controller.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({Key? key}) : super(key: key);

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  bool isMainExchanged = true;

  @override
  Widget build(BuildContext context) {
    stateFunction() {
      HapticFeedback.mediumImpact();
      setState(() {
        isMainExchanged = !isMainExchanged;
      });
    }

    final BannerAd myBanner = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6165990729522112/5363786591'
          : 'ca-app-pub-3940256099942544/2934735716',
      size:
      AdSize(width: MediaQuery.of(context).size.width.toInt(), height: 100),
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    myBanner.load();

    final AdWidget adWidget = AdWidget(ad: myBanner);


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      key: Key('animator'),
                      top: isMainExchanged ? 0 : 100,
                      curve: Curves.bounceOut,
                      duration: Duration(milliseconds: 500),
                      child: NumberRowResult(
                          key: Key('row1'), activeCalculator: isMainExchanged),
                    ),
                    AnimatedPositioned(
                      key: Key('animator2'),
                      top: isMainExchanged ? 100 : 0,
                      // left: 0,
                      curve: Curves.bounceOut,
                      duration: Duration(milliseconds: 500),
                      child: NumberRowResult(
                          key: Key('row2'), activeCalculator: !isMainExchanged),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  children: <Widget>[
                    const CharacterCalculator(character: '7'),
                    const CharacterCalculator(character: '8'),
                    const CharacterCalculator(character: '9'),
                    SymbolCalculator(
                      symbolCalculatorCharacter:
                          SymbolCalculatorCharacter.SWITCH,
                      callable: stateFunction,
                    ),
                    const CharacterCalculator(character: '4'),
                    const CharacterCalculator(character: '5'),
                    const CharacterCalculator(character: '6'),
                    SymbolCalculator(
                        symbolCalculatorCharacter:
                            SymbolCalculatorCharacter.PLUS),
                    const CharacterCalculator(character: '1'),
                    const CharacterCalculator(character: '2'),
                    const CharacterCalculator(character: '3'),
                    SymbolCalculator(
                        symbolCalculatorCharacter:
                            SymbolCalculatorCharacter.MINUS),
                    const CharacterCalculator(character: '.'),
                    const CharacterCalculator(character: '0'),
                    SymbolCalculator(
                        symbolCalculatorCharacter:
                            SymbolCalculatorCharacter.REMOVE),
                    SymbolCalculator(
                        symbolCalculatorCharacter:
                            SymbolCalculatorCharacter.EQUAL),
                  ],
                ),
              )),
              SizedBox(
                height: 100,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                  child: adWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
