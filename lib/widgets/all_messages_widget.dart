import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Text.dart';

class AllMessagesWidget extends StatelessWidget {
  final Future<List<String>> messagesFuture;

  const AllMessagesWidget({super.key, required this.messagesFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: messagesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: CustomText(
              text: snapshot.error.toString(),
              color: ColorsHelper.white,
              fontSize: 14.sp,
            ),
          );
        }

        final messages = snapshot.data ?? [];
        if (messages.isEmpty) {
          return Center(
            child: CustomText(
              text: "No messages yet",
              color: ColorsHelper.white,
              fontSize: 12.sp,
            ),
          );
        }

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: ListTile(
                title: CustomText(
                  text: messages[index],
                  color: ColorsHelper.white,
                  fontSize: 15.sp,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
