import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(250, 250, 250, 1),
      child: SafeArea(
        child: Column(
          children: const [
            Center(
                child: Text(
              "Settings",
              style: TextStyle(
                  fontSize: 20,
                  color:  Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Urbanist'),
            )),

          ],
        ),
      ),
    );
  }
}
