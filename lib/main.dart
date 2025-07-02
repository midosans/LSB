import 'package:flutter/material.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/pages/welcome.dart';

void main() {
  runApp(const LSB());
}

class LSB extends StatelessWidget {
  const LSB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LSB SECRET',
      theme: ThemeData( scaffoldBackgroundColor: ColorsHelper.black,),
      home: WelcomePage(),
    );
  }
}