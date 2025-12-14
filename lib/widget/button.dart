import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonLogin(Size size,
    {required String text,
    required bool obs,
    required String label,
    required String hint,
    required dynamic Function(dynamic)? onChanged,
    bool isHaseror = false,
    TextInputType? textInput // calllback untuk onchanged function
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontFamily: "DM Sans Semibold",
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        width: 350.w,
        child: TextFormField(
          onChanged: onChanged,
          keyboardType: textInput,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: "DM Sans Regular",
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isHaseror ? Colors.red : Colors.blueAccent,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: isHaseror ? Colors.red : Colors.grey),
            ),
          ),
        ),
      ),
    ],
  );
}

SizedBox buttonLoginTap(Size size, Color? colorbtns,
    {required String text,
    required Color colorbtn,
    required Color textColor,
    Widget? child,
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
        child: child ??
            Text(
              text,
              style: GoogleFonts.outfit(color: textColor),
            )),
  );
}
