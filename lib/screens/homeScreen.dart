import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      //   backgroundColor: const Color(0xff252422),
      // ),
      body: Center(
        child: Image.asset('assets/BG.png'),
      ),
    );
  }
}