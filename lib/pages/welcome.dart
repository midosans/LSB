import 'package:flutter/material.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/screens/LoginScreen.dart';
import 'package:lsb/screens/SignupScreen.dart';
import 'package:lsb/widgets/custom_Button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/main.png', width: 300, height: 320),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                size: Size(250, 50),
                text: 'login',
                color: ColorsHelper.orange,
                fontSize: 19,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              size: Size(250, 50),
              text: "sign up",
              color: ColorsHelper.orange,
              fontSize: 19,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
