import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_home/controller/calculator_controller.dart';
import 'calculator_home/views/calculator_home.dart';
import 'utils/applicationt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          Application.geralContext = context;
          return CalculatorController();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CalculatorHome(),
      ),
    );
  }
}
