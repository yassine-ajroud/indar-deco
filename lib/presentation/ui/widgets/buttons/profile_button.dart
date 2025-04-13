import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';


class ProfileButton extends StatelessWidget {
  final String icon;
  final String text;
  final bool? alert;
  final void Function() onClick;
  const ProfileButton({super.key, required this.icon, required this.text,required this.onClick , this.alert});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: 325.w,
          height: 60.h,
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(13.r)),
          child: Padding(
            padding:  EdgeInsets.all(8.0.r),
            child: Row(
              children: [
                Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.primary)),
                  child: Center(child: SvgPicture.string(icon,color: AppColors.primary,)),
                ), 
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 220.w,
                  child: Text(text, style: AppTextStyle.blackTextStyle,overflow: TextOverflow.visible,)),
                alert??false? const Icon(Icons.priority_high_rounded,color: AppColors.red,) :const SizedBox()  
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
