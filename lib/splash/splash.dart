import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
          "assets/images/splash_background.svg",
          height: 32,
          width: 32,
          semanticsLabel: 'A red up arrow'),
    );
  }
}
