import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Image.asset('assets/main.png', width: 300.w, height: 320.h),
            SizedBox(height: 100.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                size: Size(150.w, 60.h),
                text: 'login',
                color: ColorsHelper.orange,
                fontSize: 19.sp,
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
            SizedBox(height: 20.h),
            CustomButton(
              size: Size(150.w, 70.h),
              text: "sign up",
              color: ColorsHelper.orange,
              fontSize: 19.sp,
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
