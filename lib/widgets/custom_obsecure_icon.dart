import 'package:flutter/material.dart';

class CustomObsecureIcon extends StatefulWidget {
  const CustomObsecureIcon({super.key});

  @override
  State<CustomObsecureIcon> createState() => _CustomObsecureIconState();
}

class _CustomObsecureIconState extends State<CustomObsecureIcon> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isObscureText ? Icons.visibility_off : Icons.visibility,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          isObscureText = !isObscureText;
        });
      },
    );
  }
}
