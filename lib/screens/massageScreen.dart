import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/all_messages_widget.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/drawer.dart';

class Massagescreen extends StatelessWidget {
  const Massagescreen({super.key});
  final List<CustomText> tiles = const [
    CustomText(text: 'message', color: ColorsHelper.white, fontSize: 18),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: HomeDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsHelper.orange),
        title: CustomText(
                text: 'Saved message',
                color: ColorsHelper.orange,
                fontSize: 24.sp,
              ),
        backgroundColor: ColorsHelper.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: '  Your Messages',
                color: ColorsHelper.white,
                fontSize: 24.sp,
              ),
            ),
             Divider(thickness: 1, indent: 10, endIndent: 10, height: 15.h),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: 300.h,
                width: double.infinity,
                child:AllMessagesWidget()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
