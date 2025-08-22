import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/cubit/auth_cubit.dart';
import 'package:lsb/cubit/auth_state.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/pages/home.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/custom_TextField.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginForm> {
  String? userName, password;
  bool isobsecure = true;
  bool ischecked = false;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      builder:
          (context, state) => SingleChildScrollView(
            child: Stack(
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        LabelText: 'User Name',
                        PrefixIconPath: 'assets/profile.png',
                        onChanged: (value) {
                          userName = value;
                        },
                      ),
                      SizedBox(height: 15.h),
                      CustomTextfield(
                        LabelText: 'Password',
                        PrefixIconPath: 'assets/password.png',
                        IsObscureText: isobsecure,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Checkbox(
                            value: ischecked,
                            onChanged: (value) {
                              setState(() {
                                ischecked = value!;
                              });
                            },
                            activeColor: ColorsHelper.orange,
                          ),
                          CustomText(
                            text: 'Remember me',
                            color: ColorsHelper.white,
                            fontSize: 16.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        size: Size(170.w, 50.h),
                        color: ColorsHelper.orange,
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).login(
                              user_name: userName!,
                              password: password!,
                              rememberMe: ischecked,
                            );
                          }
                        },
                        text: 'login',
                      ),
                    ],
                  ),
                ),
                if (state is LoginLoading)
                  Container(
                    color: Colors.black.withOpacity(0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorsHelper.orange,
                      ),
                    ),
                  ),
              ],
            ),
          ),
    );
  }
}
