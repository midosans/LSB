import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/services/save_image_from_memory.dart';
import 'package:lsb/widgets/custom_Button.dart';

class CustomEmbedPopup extends StatelessWidget {
  final Image? image;
  final Uint8List bytes;
  const CustomEmbedPopup({super.key, required this.image, required this.bytes});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 15.0.h,
              ),
              child: SizedBox(
                height: 350.h,
                width: 700.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: FittedBox(
                    child: image ?? Image.asset('assets/BG.png'),
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
                    try {
                      await saveImageFromMemory(
                        context,
                        bytes,
                        "embedded.png",
                      ); // use helper
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Image saved ✅")),
                      );
                    } catch (e) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Failed: $e")));
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
    );
  }
}
