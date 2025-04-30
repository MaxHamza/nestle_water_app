import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hide,
    required this.controller,
    required this.hintText,
    this.validate,
    this.keyboardType,
    this.label,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validate;
  final TextInputType? keyboardType;
  final String? label;
  final bool? hide;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validate,
        controller: controller,
        obscureText: hide ?? false,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
         // floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
            margin: const EdgeInsets.all(9),
            child: Text(
              label ?? '',
              style: TextStyle(color: Colors.black), // Explicit text color
            ),
          ),
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: grey),
        ),
      ),
    );
  }
}