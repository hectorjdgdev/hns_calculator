import 'package:flutter/material.dart';

class RectangularButton extends StatefulWidget {
  const RectangularButton({Key? key}) : super(key: key);

  @override
  State<RectangularButton> createState() => _RectangularButtonState();
}

class _RectangularButtonState extends State<RectangularButton> {
  Color normalColor = Color.fromRGBO(46, 117, 255, 1);
  Color pressedColor = Colors.white;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (tap){
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (tap){
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isPressed ? pressedColor:  normalColor,
          borderRadius: BorderRadius.circular(6)
        ),
        child:  Center(
          child: Text(
            "DONATE",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color:  isPressed ? normalColor : pressedColor ,
                fontFamily: 'Urbanist'),
          ),
        ),
      ),
    );
  }
}
