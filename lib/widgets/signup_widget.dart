import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lsb/cubit/auth_cubit.dart';
import 'package:lsb/cubit/auth_state.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_TextField.dart';
import 'package:lsb/widgets/custom_obsecure_icon.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final formkey = GlobalKey<FormState>();
  String? userName, password, pass_confirm;
  bool isobsecure = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
        } else if (state is RegeisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is Registersuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("user created"),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Form(
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
            SizedBox(height: 15),
            CustomTextfield(
              LabelText: 'Confirm Password',
              PrefixIconPath: 'assets/password.png',
              IsObscureText: isobsecure,
              onChanged: (value) {
                pass_confirm = value;
              },
              SuffixIcon: CustomObsecureIcon(),
            ),

            SizedBox(height: 30),
            CustomButton(
              size: Size(170, 50),
              color: ColorsHelper.orange,
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).register(
                  user_name: userName!,
                  password: password!,
                  pass_confirm: pass_confirm!,
                );
              },
              text: 'register',
            ),
          ],
        ),
      ),
    );
  }
}
