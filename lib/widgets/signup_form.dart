import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/cubit/auth_cubit.dart';
import 'package:lsb/cubit/auth_state.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_TextField.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupForm> {
  final formkey = GlobalKey<FormState>();
  String? userName, password, pass_confirm;
  bool isobsecure = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegeisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is Registersuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User created'),
              backgroundColor: Colors.green,
            ),
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
                        SuffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isobsecure = !isobsecure;
                            });
                          },
                          child: Icon(
                            isobsecure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      CustomTextfield(
                        LabelText: 'Confirm Password',
                        PrefixIconPath: 'assets/password.png',
                        IsObscureText: isobsecure,
                        onChanged: (value) {
                          pass_confirm = value;
                        },
                      ),

                      SizedBox(height: 30.h),
                      CustomButton(
                        size: Size(170.w, 50.h),
                        color: ColorsHelper.orange,
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).register(
                              user_name: userName!,
                              password: password!,
                              pass_confirm: pass_confirm!,
                            );
                          }
                        },
                        text: 'register',
                      ),
                    ],
                  ),
                ),
                if (state is RegisterLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
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
