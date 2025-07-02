import 'package:flutter/material.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/screens/embedScreen.dart';
import 'package:lsb/screens/extractScreen.dart'; 
import 'package:lsb/screens/homeScreen.dart'; 
import 'package:lsb/screens/massageScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  int index = 0;
  final screens = [
    Homescreen(),
    Embedscreen(),
    Extractscreen(),
    Massagescreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //rgb(235, 94, 40)
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: ColorsHelper.orange,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        height: 48,
        index: index,
        items: <Widget>[
          Image.asset('assets/home.png', width: 30, height: 30),
          Image.asset('assets/decoder.png', width: 30, height: 30),
          Image.asset('assets/encoder.png', width: 30, height: 30),
          Image.asset('assets/saves.png', width: 30, height: 30),
          ],
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}
