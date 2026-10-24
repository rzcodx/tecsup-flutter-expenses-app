import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? function;

  const FieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        onTap: function,
        readOnly: function != null ? true : false,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey.shade300,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
