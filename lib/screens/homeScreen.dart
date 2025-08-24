import 'package:flutter/material.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/drawer.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
          drawer: HomeDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorsHelper.orange),
            backgroundColor: ColorsHelper.black,
          ),
      body: Center(
        child: Image.asset('assets/BG.png'),
      ),
    );
  }
}