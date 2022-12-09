import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hns_calculator/settings/views/settings.dart';

import 'calculator_home.dart';

class CalculatorContainer extends StatefulWidget {
  const CalculatorContainer({Key? key}) : super(key: key);

  @override
  State<CalculatorContainer> createState() => _CalculatorContainerState();
}

class _CalculatorContainerState extends State<CalculatorContainer> {
  final PageController controller = PageController();
  double page = 0;

  @override
  void initState() {
    controller.addListener((){
      setState(() {
        page = controller.page!;
      });
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {


    return Stack(
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
    );
  }
}
