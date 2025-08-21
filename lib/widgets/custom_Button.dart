import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.size,
    required this.color,
    super.key,
    this.fontSize,
    this.onPressed,
  });
  final String text;
  final Size size;
  final Color color;
  final double? fontSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        backgroundColor: color,
      ),
      onPressed: onPressed ?? () {},
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? 18.sp,
          fontFamily: 'Kdam Thmor Pro',
        ),
      ),
    );
  }
}
