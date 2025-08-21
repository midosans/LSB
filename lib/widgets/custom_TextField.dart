import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lsb/widgets/custom_obsecure_icon.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    required this.LabelText,
    super.key,
    this.PrefixIconPath,
    this.IsObscureText,
    this.SuffixIcon,
    this.controller,
    this.readOnly,
    this.onChanged,
  });

  final String LabelText;
  final String? PrefixIconPath;
  final bool? IsObscureText;
  final Widget? SuffixIcon;
  final TextEditingController? controller;
  final bool? readOnly;
  final void Function(String)? onChanged;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  late bool isObscureText;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.IsObscureText ?? false;
  }

  void toggleObscureText() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      onChanged: (value) {
        widget.onChanged?.call(value);
        fieldKey.currentState?.validate();
      },
      readOnly: widget.readOnly ?? false,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.LabelText}';
        }
        return null;
      },
      style: const TextStyle(color: Colors.white, fontFamily: 'Kdam Thmor Pro'),
      obscureText: isObscureText,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child:
              widget.PrefixIconPath != null
                  ? Image.asset(widget.PrefixIconPath!)
                  : null,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 40.0.h,
          maxWidth: 40.0.w,
        ),
        suffixIcon:
            (widget.IsObscureText ?? false)
                ? CustomObsecureIcon(
                  isObscure: isObscureText,
                  toggle: toggleObscureText,
                )
                : widget.SuffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: widget.LabelText,
        labelStyle: const TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
