import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatelessWidget {

  final TextEditingController? controller_name;
  final String? hint_text;
  final Widget? prefix_icon;


  MyTextfield({
    super.key,
    this.controller_name,
    this.hint_text,
    this.prefix_icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
      child: TextFormField(
        style: TextStyle(
            color: Colors.white
        ),
        cursorColor: Colors.white,
        controller: controller_name,
        decoration: InputDecoration(
          hintText: hint_text,
          filled: true,
          fillColor: Colors.white12,
          hintStyle: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          prefixIcon: prefix_icon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}