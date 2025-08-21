import 'package:flutter/material.dart';

class CustomObsecureIcon extends StatelessWidget {
  final bool isObscure;
  final VoidCallback toggle;

  const CustomObsecureIcon({
    super.key,
    required this.isObscure,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isObscure ? Icons.visibility_off : Icons.visibility,
        color: Colors.white,
      ),
      onPressed: toggle,
    );
  }
}
