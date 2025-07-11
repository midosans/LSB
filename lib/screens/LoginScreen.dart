import 'package:flutter/material.dart';
import 'package:lsb/widgets/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  bool isobsecure = true;
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Color(0xff252422),
        iconTheme: IconThemeData(
          color: Colors.white, // Change the color of the back button
        ),
      ),
      extendBody: true,
      body: Center(
        child: SizedBox(
          width: 300,
          height: 550,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo2.png'),
                  height: 180,
                  width: 200,
                ),
                SizedBox(height: 10),
                LoginWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
