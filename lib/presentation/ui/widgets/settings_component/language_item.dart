import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';




// ignore: must_be_immutable
class LanguageItem extends StatelessWidget {
  final String language;
  final String value;
  final void Function(String?) onChanged;
  final String gvalue;
  const LanguageItem({
    super.key,
    required this.language,
    required this.value,
     required this.gvalue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
   padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
    //       boxShadow:const [
    //   // BoxShadow(
    //   //   color: AppColors.lightShadow,
    //   //   spreadRadius: 1,
    //   //   blurRadius: 8,
    //   //   offset: Offset(0, 4), // changes position of shadow
    //   // ),
    // ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              language,
              style: AppTextStyle.blackTextStyle,
            ),
           
               Radio<String>(
                      activeColor: AppColors.primary,
                      value: value,
                      groupValue: gvalue,
                      onChanged:onChanged
                    )
          ]),
        ),
      ),
    );
  }
}
