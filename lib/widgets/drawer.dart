import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/cubit/auth_cubit.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/pages/welcome.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserDataFromToken();
  }

  Future<void> _loadUserDataFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(color: ColorsHelper.black),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 160.h,
                width: double.infinity,
                decoration: BoxDecoration(color: ColorsHelper.orange),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: userName ?? 'Guest User',
                            color: ColorsHelper.white,
                            fontSize: 24.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red, size: 28),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BlocProvider(
                              create: (context) => AuthCubit(),
                              child: WelcomePage(),
                            ),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
