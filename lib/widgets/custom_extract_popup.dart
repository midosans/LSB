import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/cubit/lsb.state.dart';
import 'package:lsb/cubit/lsb_cubit.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/services/refresh_service.dart';
import 'package:lsb/widgets/custom_Button.dart';
import 'package:lsb/widgets/custom_Text.dart';

class CustomExtractPopup extends StatelessWidget {
  final String? message;
  const CustomExtractPopup({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LsbCubit, LsbState>(
      listener: (context, state) {
        if (state is SaveMessageLoading) {
          // Show loading indicator
        } else if (state is SaveMessageFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is SaveMessageSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("saved successfully"),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: ColorsHelper.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'your massage',
                    color: ColorsHelper.white,
                    fontSize: 22.sp,
                  ),
                  CustomButton(
                    size: Size(35.w, 35.h),
                    text: 'copy',
                    color: Colors.grey,
                    onPressed:(){ Clipboard.setData(ClipboardData(text: message!));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Copied to clipboard!"),
                  ),);})
                ],
              ),
              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 20.0.w,
                  vertical: 15.0.h,
                ),
                child: SizedBox(
                  height: 250.h,
                  width: 600.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: CustomText(
                        text: message ?? "",
                        color: ColorsHelper.white,
                        fontSize: 15.h,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    size: Size(90.w, 50.h),
                    text: 'save',
                    color: ColorsHelper.orange,
                    onPressed: () async {
                      if (await RefreshService()) {
                        Navigator.of(context).pop();
                        BlocProvider.of<LsbCubit>(
                          context,
                        ).saveMessage(message: message!);
                      } else {
                        Navigator.of(context).pop();
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
                  CustomButton(
                    size: Size(90.w, 50.h),
                    text: 'cancel',
                    color: ColorsHelper.orange,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
