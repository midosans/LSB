import 'package:flutter/material.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/pages/home.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_TextField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  bool isobsecure_1 = true;
  bool isobsecure_2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: ColorsHelper.black,
        iconTheme: IconThemeData(
          color: Colors.white, // Change the color of the back button
        ),
      ),
      extendBody: true,
      body: Center(
        child: SizedBox(
          width: 300,
          height: 550,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo2.png'),
                  height: 180,
                  width: 200,
                ),
                SizedBox(height: 10),

                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        LabelText: 'User Name',
                        PrefixIconPath: 'assets/profile.png',
                      ),
                      SizedBox(height: 15),
                      CustomTextfield(
                        LabelText: 'password',
                        PrefixIconPath: 'assets/password.png',
                        IsObscureText: isobsecure_1,
                        SuffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isobsecure_1 = !isobsecure_1;
                            });
                          },
                          child: Icon(
                            isobsecure_1
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomTextfield(
                        LabelText: 'confrim password',
                        PrefixIconPath: 'assets/password.png',
                        IsObscureText: isobsecure_2,
                        SuffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isobsecure_2 = !isobsecure_2;
                            });
                          },
                          child: Icon(
                            isobsecure_2
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      CustomButton(
                        size: Size(170, 50),
                        color: ColorsHelper.orange,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        text: 'sign up',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
