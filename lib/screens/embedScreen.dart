import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/custom_TextField.dart';
import 'package:lsb/widgets/custom_embed_popup.dart';
import 'package:lsb/widgets/custom_obsecure_icon.dart';
import 'package:path/path.dart';

class Embedscreen extends StatefulWidget {
  const Embedscreen({super.key});

  @override
  State<Embedscreen> createState() => _EmbedscreenState();
}

class _EmbedscreenState extends State<Embedscreen> {
  final _controller = TextEditingController();
  String imageName = '';
  File imageFile = File('');
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          'Embed Screen',
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
                child: CustomText(
                  text: 'Embed Message',
                  color: ColorsHelper.orange,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'Your Message',
                  color: ColorsHelper.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextfield(LabelText: 'Enter your message'),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'upload Image',
                  color: ColorsHelper.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                controller: _controller,
                LabelText: 'Enter image URL',
                SuffixIcon: IconButton(
                  icon: Image.asset(
                    'assets/download.png',
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () async {
                    final XFile? pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      final fileName = basename(pickedFile.path);

                      setState(() {
                        _controller.text = fileName;
                        imageName = fileName;
                        imageFile = File(pickedFile.path);
                      });
                    } else {
                      return;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'Password',
                  color: ColorsHelper.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                LabelText: 'Enter your Password',
                IsObscureText: isObscureText,
                SuffixIcon: CustomObsecureIcon(),
              ),

              const SizedBox(height: 70),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  size: Size(150, 50),
                  color: ColorsHelper.orange,
                  text: 'embed',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CustomEmbedPopup(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
