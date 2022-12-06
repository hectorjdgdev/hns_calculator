import 'package:flutter/material.dart';

class RectangularButton extends StatefulWidget {
  const RectangularButton({Key? key}) : super(key: key);

  @override
  State<RectangularButton> createState() => _RectangularButtonState();
}

class _RectangularButtonState extends State<RectangularButton> {
  Color normalColor = Color.fromRGBO(46, 117, 255, 1);
  Color pressedColor = Colors.red;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return Colors.white;
              return Colors.blue; // Defer to the widget's default.
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return Colors.blue;
              return Colors.white; // Defer to the widget's default.
            }),
            textStyle: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return size 40, otherwise 20
              return const TextStyle(
                  fontSize: 20, fontFamily: 'Urbanist-Light');
            }),
          ),
          onPressed: () {},
          child: const Text("DONATE")),
    );
  }
}
