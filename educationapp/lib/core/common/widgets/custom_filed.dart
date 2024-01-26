import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    required this.controller,
    required this.hintText,
     this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    this.overrideValidator = false,
    super.key,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.keyboardType,
    this.hintStyle,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(90)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: filled,
        fillColor: fillColour,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
