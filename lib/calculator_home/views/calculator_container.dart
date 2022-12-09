import 'dart:async';
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hns_calculator/settings/views/settings.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'calculator_home.dart';

class CalculatorContainer extends StatefulWidget {
  const CalculatorContainer({Key? key}) : super(key: key);

  @override
  State<CalculatorContainer> createState() => _CalculatorContainerState();
}

class _CalculatorContainerState extends State<CalculatorContainer> {
  late StreamSubscription<dynamic> _subscription;

  final PageController controller = PageController();
  double page = 0;


  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    final Stream purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      // _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    controller.addListener((){
      setState(() {
        page = controller.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          PageView(
            controller: controller,
            physics: const ClampingScrollPhysics(),
            children: const [
              CalculatorHome(),
              SettingsScreen()
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 20,
              margin: EdgeInsets.only(bottom: 10),
              child: DotsIndicator(
                dotsCount: 2,
                position:  page,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
