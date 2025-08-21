import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/cubit/auth_cubit.dart';
import 'package:lsb/cubit/auth_state.dart';
import 'package:lsb/cubit/lsb_cubit.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/pages/home.dart';
import 'package:lsb/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LsbCubit()),
      ],
      child: const LSB(),
    ),
  );
}

class LSB extends StatelessWidget {
  const LSB({super.key});

  Future<Widget> getInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      return BlocProvider(create: (context) => LsbCubit(), child: HomePage());
    } else {
      return BlocProvider(
        create: (context) => AuthCubit(),
        child: WelcomePage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: Builder(
            builder:
                (context) => BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'LSB SECRET',
                      theme: ThemeData(
                        scaffoldBackgroundColor: ColorsHelper.black,
                      ),
                      home: FutureBuilder<Widget>(
                        future: getInitialScreen(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            return snapshot.data!;
                          }
                        },
                      ),
                    );
                  },
                ),
          ),
        );
      },
    );
  }
}
