import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indar_deco/core/styles/text_styles.dart';
import 'package:indar_deco/domain/entities/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:0.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(255, 190, 190, 190),
              BlendMode.modulate,
            ),
            child: Image.network(category.image,fit: BoxFit.cover, width: 160.w,height: 180.h,))),
        Positioned(
          bottom: 40,
          child: Text(category.title,style: AppTextStyle.whiteTextStyle,))
      ],),
    );
  }
}