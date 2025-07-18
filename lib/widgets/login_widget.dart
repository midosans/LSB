import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lsb/cubit/auth_cubit.dart';
import 'package:lsb/cubit/auth_state.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/pages/home.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/custom_TextField.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formkey = GlobalKey<FormState>();
  String? userName,password;
  bool isobsecure = true;
  bool ischecked = false;
  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<AuthCubit>(context);
    // return BlocConsumer<AuthCubit, AuthState>(
    //   listener: (context, state) {
    //     if (state is LoginFailure) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(state.message), backgroundColor: Colors.red),
    //       );
    //     } else if (state is LoginSuccess) {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => const HomePage()),
    //       );
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state is LoginLoading) {
    //       return const Center(child: (Placeholder()));
    //     }

        return Form(
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
              SizedBox(height: 15),
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
                    isobsecure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 5),
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
                    fontSize: 16,
                  ),
                ],
              ),
              SizedBox(height: 30),
              CustomButton(
                size: Size(170, 50),
                color: ColorsHelper.orange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                text: 'login',
              ),
            ],
          ),
        );
  }
}
