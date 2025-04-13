import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indar_deco/core/styles/colors.dart';
import 'package:indar_deco/core/styles/text_styles.dart';




// ignore: must_be_immutable
class SettingsItem extends StatelessWidget {
  final String icon;
  final String text;
  final Widget trailing;
  const SettingsItem({
    super.key,
    required this.icon,
    required this.text,
     required this.trailing,
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
              Row(children: [
               Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.primary)),
                  child: Center(child: SvgPicture.string(icon,color: AppColors.primary,)),
                ),
               const SizedBox(width: 15,),
            Text(
              text,
              style: AppTextStyle.blackTextStyle,
            ),
            const Spacer(),
           trailing
          ]),
        ),
      ),
    );
  }
}
