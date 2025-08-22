import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/screens/embedScreen.dart';
import 'package:lsb/screens/extractScreen.dart';
import 'package:lsb/screens/homeScreen.dart';
import 'package:lsb/screens/massageScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lsb/services/get_message.dart';
import 'package:lsb/services/refresh_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  late Future<List<String>> messagesFuture;

  @override
  void initState() {
    super.initState();
    messagesFuture = _loadMessages();
  }

  Future<List<String>> _loadMessages() async {
    final refreshOk = await RefreshService();
    if (!refreshOk) {
      throw Exception("Refresh token expired, please login again");
    }

    final service = MessageService();
    return await service.getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      Homescreen(),
      Embedscreen(),
      Extractscreen(),
      Massagescreen(messagesFuture: messagesFuture, onRefresh: () {
        setState(() {
          messagesFuture = _loadMessages();
        });
      }),
    ];

    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: ColorsHelper.orange,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        height: 48.h,
        index: index,
        items: <Widget>[
          Image.asset('assets/home.png', width: 30.w, height: 30.h),
          Image.asset('assets/decoder.png', width: 30.w, height: 30.h),
          Image.asset('assets/encoder.png', width: 30.w, height: 30.h),
          Image.asset('assets/saves.png', width: 30.w, height: 30.h),
        ],
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}
