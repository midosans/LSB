import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/drawer.dart';
import 'package:lsb/widgets/extract_form.dart';

class Extractscreen extends StatelessWidget {
  const Extractscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          extendBody: true,
          drawer: HomeDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorsHelper.orange),
            title: CustomText(
              text: "Extract Message",
              color: ColorsHelper.orange,
              fontSize: 24.sp,
            ),
            backgroundColor: ColorsHelper.black,
          ),
          body: ExtractForm()
        );
  }
}
