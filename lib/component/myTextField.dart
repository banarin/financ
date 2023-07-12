import 'package:flutter/material.dart';

class myTextField extends StatelessWidget {
  final controler;
  final String hindText;
  final bool obscured;
  final TextInputType type;
  const myTextField({
    super.key,
    required this.controler,
    required this.hindText,
    required this.obscured,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controler,
         keyboardType: type,
        obscureText: obscured,
        decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300)),
          fillColor: Colors.white,
          filled: true,
          hintText: hindText,
          
        ),
      ),
    );
  }
}
