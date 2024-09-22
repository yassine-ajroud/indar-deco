import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';

class PrimaryTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final int width;
  final int height;

  const PrimaryTextField(
      {super.key,
      required this.text,
      required this.controller,
      required this.keyboardType,
      required this.validator,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black.withOpacity(0.9)),
        decoration: InputDecoration(
             enabledBorder: const UnderlineInputBorder(      
                      borderSide: BorderSide(color:AppColors.grey),   
                      ),  
              focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                   ),  
         
          hintText: text,
          hintStyle: AppTextStyle.lightLabelTextStyle,
         // labelStyle: TextStyle(color: AppColors.black.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: AppColors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}