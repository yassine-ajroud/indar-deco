import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color color;
  final void Function()  onPress;
  const QuantityButton({super.key , required this.backgroundColor, required this.icon, required this.onPress,required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8)
        ),
        height: 30.h,
        width: 30.w,
        child:Icon(icon,color: color,) ,
      ),
    );
  }
}