import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lsb/cubit/auth_cubit.dart';
import 'package:lsb/cubit/auth_state.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/pages/welcome.dart';

void main() {
  runApp(const LSB());
}

class LSB extends StatelessWidget {
  const LSB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(
        builder:
            (context) => BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'LSB SECRET',
                  theme: ThemeData(scaffoldBackgroundColor: ColorsHelper.black),
                  home: WelcomePage(),
                );
              },
            ),
      ),
    );
  }
}
