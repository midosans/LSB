import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.size,
    required this.text,
    this.onPressed,
    required this.color,
    this.fontSize,
  });
  final Size size;
  final String text;
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
          fontSize: fontSize ?? 18,
          fontFamily: 'Kdam Thmor Pro',
        ),
      ),
    );
  }
}
