import 'package:flutter/material.dart';

class CursorElement extends StatefulWidget {
  const CursorElement({Key? key}) : super(key: key);

  @override
  State<CursorElement> createState() => _CursorElementState();
}

class _CursorElementState extends State<CursorElement>
    with SingleTickerProviderStateMixin {
   late AnimationController controller;
   int _visible = 1;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward()..repeat();

    controller.addListener(() {
      if(controller.value.toStringAsFixed(0) !=  _visible ){
        setState(() {
          _visible = int.parse(controller.value.toStringAsFixed(0));
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Opacity(
        opacity: _visible == 1 ? 1.0 : 0.0,
        child: Container(
          height: 56,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          width: 2,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromRGBO(46, 117, 255, 1),
          ),
        ),
      );
  }
}
