import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownMenu extends StatelessWidget {
   String change;
  DropDownMenu({super.key, required this.change});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField(
        items: [
          DropdownMenuItem(value: "Nouveau", child: Text("Nouveau Carnet")),
          DropdownMenuItem(value: "Ancien", child: Text("Ancien Carnet")),
        ],
        value: change,
        decoration: const InputDecoration(
          
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          change = value!;
        },
      ),
    );
  }
}
