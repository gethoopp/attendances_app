import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonLogin(Size size,
    {required String text,
    required bool obs,
    required TextEditingController controll,
    required String? Function(String)? validator, // Callback untuk validasi
    required String? Function(String)? onChanged,
    TextInputType? textInput // calllback untuk onchanged function
    }) {
  return SizedBox(
    width: size.width * 0.85,
    child: TextFormField(
      onChanged: onChanged,
      controller: controll,
      obscureText: obs,
      keyboardType: textInput,
      decoration: InputDecoration(
        errorText: validator?.call(controll.text), // Panggil fungsi validasi
        focusColor: Colors.blue[600],
        hoverColor: Colors.blue[600],
        fillColor: Colors.blue[600],
        labelText: text,
        labelStyle: GoogleFonts.outfit(fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

SizedBox buttonLoginTap(Size size, Color? colorbtns,
    {required String text,
    required Color colorbtn,
    required Color textColor,
    Function()? onTap}) {
  return SizedBox(
    width: size.width * 0.85,
    height: size.height * 0.06,
    child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(colorbtn),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(color: colorbtns ?? Colors.blue),
                borderRadius: const BorderRadius.all(Radius.circular(10))))),
        child: Text(
          text,
          style: GoogleFonts.outfit(color: textColor),
        )),
  );
}
