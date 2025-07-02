import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key, required this.LabelText, this.onChanged,this.PrefixIconPath, this.IsObscureText, this.SuffixIcon});

  final String LabelText;
  final String? PrefixIconPath;
  final Widget? SuffixIcon;
  final void Function(String)? onChanged;
  final bool? IsObscureText;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final GlobalKey<FormFieldState> fieldKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      key: fieldKey,
      onChanged: (value) 
      {
        widget.onChanged?.call(value);
        fieldKey.currentState?.validate();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.LabelText}';
        }
        return null;
      },
      style: TextStyle(color: Colors.white , fontFamily: 'Kdam Thmor Pro'),
      obscureText: widget.IsObscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: widget.PrefixIconPath != null ? Image.asset(widget.PrefixIconPath!) : null,
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 40.0, maxWidth: 40.0),
        suffixIcon: widget.SuffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: widget.LabelText,
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
