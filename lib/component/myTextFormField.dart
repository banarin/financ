import 'package:flutter/material.dart';

class myTextFormField extends StatelessWidget {
  final controler;
  final String hindText;
  final bool obscured;
  final TextInputType type;
  final String labelText;
  const myTextFormField({
    super.key,
    required this.controler,
    required this.hindText,
    required this.obscured,
    required this.type,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controler,
        keyboardType: type,
        obscureText: obscured,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
          hintText: hindText,
          labelText: labelText,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Ce champ est vide";
          }
        },
      ),
    );
  }
}
