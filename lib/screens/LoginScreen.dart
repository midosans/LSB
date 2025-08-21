import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.h,
        backgroundColor: ColorsHelper.black,
        iconTheme: IconThemeData(
          color: ColorsHelper.white
        ),
      ),
      extendBody: true,
      body: Center(
        child: SizedBox(
          width: 300.w,
          height: 550.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo2.png'),
                  height: 180.h,
                  width: 200.w,
                ),
                SizedBox(height: 10.h),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
