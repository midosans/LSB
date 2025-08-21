import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/helper/Colors_Helper.dart';
import 'package:lsb/widgets/custom_Text.dart';
import 'package:lsb/widgets/drawer.dart';
import 'package:lsb/widgets/embed_form.dart';

class Embedscreen extends StatelessWidget {
  const Embedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          extendBody: true,
          drawer: HomeDrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorsHelper.orange),
            title: CustomText(
              text: 'Embed Message',
              color: ColorsHelper.orange,
              fontSize: 24.sp,
            ),
            backgroundColor: ColorsHelper.black,
          ),
          body: EmbedForm()
        );
      }
}

