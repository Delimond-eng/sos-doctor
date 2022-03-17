import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {Key key,
      this.controller,
      this.errorMessage,
      this.icon,
      this.title,
      this.hintText})
      : super(key: key);
  final TextEditingController controller;
  final IconData icon;
  final String title;
  final String hintText;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: title,
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: Colors.orange[900],
          size: 16.0,
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black54,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
