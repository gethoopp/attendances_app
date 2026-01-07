import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorTextFormField extends StatelessWidget {
  String? error;
  final bool showIcon;
  final double iconSize;
  final double fontSize;
  final double marginTop;
  int? lengthText;

  ErrorTextFormField({
    super.key,
    this.error,
    this.lengthText,
    this.showIcon = true,
    this.iconSize = 26,
    this.fontSize = 13,
    this.marginTop = 0,
  });

  @override
  Widget build(BuildContext context) {
    return error != null && error!.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(bottom: 5.w, left: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: marginTop),
                Row(
                  children: [
                    //bisa ditambah asset gambar
                    // if (showIcon)
                    //   Image(
                    //     image: const AssetImage(),
                    //     width: 18.w,
                    //     height: 16.h,
                    //   ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 5.h),
                      child: Text(
                        error!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: "DM Sans Regular",
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
