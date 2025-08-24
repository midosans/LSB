import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lsb/cubit/lsb.state.dart';
import 'package:lsb/cubit/lsb_cubit.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/services/refresh_service.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/custom_TextField.dart';
import 'package:lsb/widgets/custom_embed_popup.dart';
import 'package:path/path.dart';

class EmbedForm extends StatefulWidget {
  const EmbedForm({super.key});

  @override
  State<EmbedForm> createState() => _EmbedFormState();
}

class _EmbedFormState extends State<EmbedForm> {
  String imageName = '';
  String? message, password;
  File imageFile = File('');
  XFile? pickedimg;
  bool isObscureText = true;
  final _controller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LsbCubit, LsbState>(
      listener: (context, state) {
        if (state is EmbedFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is EmbedSuccess) {
          showDialog(
            context: context,
            builder: (context) =>
                CustomEmbedPopup(image: state.image, bytes: state.bytes),
          );
        }
      },
      builder: (context, state) {
        return Stack( 
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: 'Your Message',
                          color: ColorsHelper.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomTextfield(
                        LabelText: 'Enter your message',
                        onChanged: (value) {
                          message = value;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: 'Upload Image',
                          color: ColorsHelper.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomTextfield(
                        controller: _controller,
                        readOnly: true,
                        LabelText: 'Enter image URL',
                        SuffixIcon: IconButton(
                          icon: Image.asset(
                            'assets/download.png',
                            width: 30.w,
                            height: 30.h,
                          ),
                          onPressed: () async {
                            final XFile? pickedFile =
                                await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                            );

                            if (pickedFile == null) return;

                            setState(() {
                              pickedimg = pickedFile;
                              imageName = basename(pickedFile.path);
                              _controller.text = imageName;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: 'Password',
                          color: ColorsHelper.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomTextfield(
                        LabelText: 'Enter your Password',
                        IsObscureText: isObscureText,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 70.h),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomButton(
                          size: Size(150.w, 50.h),
                          color: ColorsHelper.orange,
                          text: 'embed',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (await RefreshService()) {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<LsbCubit>(context).embed(
                                  message: message!,
                                  password: password!,
                                  pickedFile: pickedimg!,
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Refresh token expired, please login again",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state is EmbedLoading)
              Container(
                color: Colors.black.withOpacity(0.4), 
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
