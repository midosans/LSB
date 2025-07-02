import 'package:flutter/material.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/custom_TextField.dart';

class Extractscreen extends StatefulWidget {
  const Extractscreen({super.key});

  @override
  State<Extractscreen> createState() => _ExtractscreenState();
}

class _ExtractscreenState extends State<Extractscreen> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          'Extract Screen',
          style: TextStyle(fontFamily: 'Kdam Thmor Pro'),
        ),
        backgroundColor: ColorsHelper.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(text: "Extract Message", color: ColorsHelper.orange, fontSize: 24)
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child:
                CustomText(text: 'Upload Image', color: ColorsHelper.white, fontSize: 18)
              ),
              const SizedBox(height: 10),
             CustomTextfield(LabelText: 'Enter image URL', 
                SuffixIcon: IconButton(
                    icon: Image.asset(
                      'assets/download.png',
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {},
                  ),
              ),

        
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: 
                CustomText(text: 'Password', color: ColorsHelper.white, fontSize: 18)
              ),
              const SizedBox(height: 10),
              CustomTextfield(LabelText: 'Enter your Password', 
                IsObscureText: isObscureText,
                SuffixIcon: IconButton(
                  icon: Icon(isObscureText? Icons.visibility_off:Icons.visibility , color: Colors.white),
                  onPressed: () {setState(() {
                    isObscureText = !isObscureText;
                  });},
                ),
              ),
              SizedBox(height: 70),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(size:Size(150, 50),color: ColorsHelper.orange , text: 'extract') 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
