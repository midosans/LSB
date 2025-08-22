import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/all_messages_widget.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/drawer.dart';

class Massagescreen extends StatelessWidget {
  final Future<List<String>> messagesFuture;
  final VoidCallback onRefresh;

  const Massagescreen({
    super.key,
    required this.messagesFuture,
    required this.onRefresh,
  });

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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: ColorsHelper.orange),
            onPressed: onRefresh, 
          ),
        ],
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
                text: ' Your Messages',
                color: ColorsHelper.white,
                fontSize: 24.sp,
              ),
            ),
            Divider(thickness: 1, indent: 10, endIndent: 10, height: 15.h),
            
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: AllMessagesWidget(messagesFuture: messagesFuture),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
