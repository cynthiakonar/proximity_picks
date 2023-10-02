import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.validator,
      this.keyboardType,
      this.textCapitalization,
      this.isObsecure = false,
      this.enableSuggestions = false});
  final String Function(String?)? validator;
  final bool isObsecure;
  final String labelText;
  final TextInputType? keyboardType;
  final bool enableSuggestions;
  final TextCapitalization? textCapitalization;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      enableSuggestions: enableSuggestions,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: isObsecure,
      validator: (val) {
        validator?.call(val);
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFFA4ACB2),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFFBBAC2),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE05656),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE05656),
            width: 2,
          ),
        ),
      ),
    );
  }
}
